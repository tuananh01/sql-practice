-- Xom Data · Players with 3 or more goals
-- Problem: https://xomdata.com/practice/medium-having-187
-- Solved: 2026-08-13

WITH GoalStats AS (
    SELECT 
        player_id, 
        COUNT(id) AS goal_count, 
        COUNT(DISTINCT match_id) AS scoring_matches
    FROM goals 
    GROUP BY player_id
    HAVING COUNT(id) >= 3 
),
PenaltyStats AS (
    SELECT 
        player_id, 
        COUNT(id) AS cards_received
    FROM penalties 
    GROUP BY player_id
)
SELECT 
    full_name,
    positions,
    team_name,
    goal_count,
    scoring_matches,
    cards_received,
    goals_per_match,
    DENSE_RANK() OVER(ORDER BY goals_per_match DESC) AS efficiency_rank,
    RANK() OVER(ORDER BY goal_count DESC) AS volume_rank 
FROM (
    SELECT 
        p.full_name,
        p.positions,
        t.team_name,
        g.goal_count, 
        g.scoring_matches,
        COALESCE(pen.cards_received, 0) AS cards_received,
        ROUND((g.goal_count * 1.0) / g.scoring_matches, 2) AS goals_per_match
    FROM players p 
    JOIN GoalStats g 
    ON g.player_id = p.id 
    LEFT JOIN teams t 
    ON t.id = p.team_id
    LEFT JOIN PenaltyStats pen 
    ON pen.player_id = p.id
) T
WHERE cards_received < 5
ORDER BY efficiency_rank, full_name
