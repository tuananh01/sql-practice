-- Xom Data · Goals and cards by team
-- Problem: https://xomdata.com/practice/medium-join-186
-- Solved: 2026-08-25

WITH goal_cnt AS (
    SELECT 
        player_id,
        COUNT(id) id
    FROM goals
    GROUP BY player_id
),
pen_cnt AS (
    SELECT
        player_id,
        COUNT(id) id
    FROM penalties
    GROUP BY player_id
)

SELECT
    *,
    RANK() OVER(ORDER BY total_goals_scored DESC) scoring_rank,
    SUM(total_goals_scored) OVER(ORDER BY total_goals_scored DESC) cumulative_goals 
FROM (
    SELECT
    t.team_name,
    t.city,
    COUNT(p.id) player_count,
    COALESCE(SUM(g.id),0) total_goals_scored, 
    COALESCE(SUM(pe.id), 0) penalty_count,
    ROUND(
        COALESCE(SUM(g.id),0)*1.0/COUNT(p.id)
    , 2) goals_per_player,
    ROUND(
        COALESCE(SUM(pe.id), 0)*1.0/COUNT(p.id) 
    , 2) cards_per_player 
FROM teams t 
JOIN players p 
ON t.id = p.team_id 
LEFT JOIN goal_cnt g 
ON p.id = g.player_id
LEFT JOIN pen_cnt pe 
ON pe.player_id = p.id
GROUP BY 1, 2
)T
ORDER BY scoring_rank, team_name
