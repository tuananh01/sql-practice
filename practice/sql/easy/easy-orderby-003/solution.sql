-- Xom Data · Most watched videos this week
-- Problem: https://xomdata.com/practice/easy-orderby-003
-- Solved: 2026-08-10

-- Viết SQL của bạn ở đây
SELECT
    video_title,
    weekly_views
FROM videos 
ORDER BY weekly_views DESC, video_title
