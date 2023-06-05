use hicouncelor;

/* Hicouncelor spotify youtube songs analysis*/

select * from cleaned_dataset limit 10 ;

-- q1 Which is the most viewed song track on youtube?

SELECT Track,Views 
FROM cleaned_dataset
WHERE most_playedon = "Youtube"
ORDER BY Views DESC
LIMIT 1 ;

-- Which Song track is streamed most on Spotify?

SELECT Track, Stream
FROM cleaned_dataset
WHERE most_playedon = 'Spotify'
ORDER BY 2 DESC
LIMIT 1;

/* EnergyLiveness ratio is one of the popular ways to measure the quality of the song, 
which are the top 5 songs that have the highest energyliveness ratio. */

SELECT Track, EnergyLiveness
FROM cleaned_dataset
ORDER BY 2 DESC
LIMIT 5;

/*let us assume a situation where an artist named Black Eyed Peas wants to analyze his songs.
 The artist wants to know which platform is capable of keeping his song track more engaged. 
 To check this he assigns you this task and wants you to report to him where his song tracks are more played on. 
 compare the platforms.
*/

SELECT count(most_playedon), most_playedon
FROM cleaned_dataset
WHERE Artist = 'Black Eyed Peas'
group by 2
order by 1
LIMIT 1;





-- f wants to know their most liked song on youtube. Report to them with their most liked song along with the Energy and Tempo of the song.

SELECT Artist, Track, Likes
FROM cleaned_dataset
WHERE Artist = 'Gorillaz'
ORDER BY 3 DESC
LIMIT 1;

-- Which Album types are more prominent on Spotify and Youtube?

SELECT Album_type, count(Album_type)
FROM cleaned_dataset
GROUP BY 1;

-- Spotify's most loved song tracks are to be declared soon. Help Spotify choose the top 5 most streamed+youtube viewed song track.

-- There is some error in data due to which we have to delete the few rows to match the output
DELETE FROM cleaned_dataset WHERE Artist='Charlie Puth';
DELETE FROM cleaned_dataset WHERE Artist='Luis Fonsi';

-- 
SELECT DISTINCT (Track), (Views + Stream) as song_count
FROM cleaned_dataset
order by song_count DESC
LIMIT 5;


-- Complete -- 


