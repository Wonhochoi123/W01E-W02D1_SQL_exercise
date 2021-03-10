/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
select artists.* from artists left join albums on artists.ArtistID=albums.ArtistID  group by artists.ArtistID having count(title)=0;



/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
select artists.* from tracks 
    join genres on genres.GenreId=tracks.GenreId 
    join albums on tracks.AlbumId=albums.AlbumId 
    join artists on artists.ArtistID=albums.ArtistID 
where genres.name='Latin' group by artists.ArtistId, genres.GenreId;

select DISTINCT artists.* from tracks 
    join genres on genres.GenreId=tracks.GenreId 
    join albums on tracks.AlbumId=albums.AlbumId 
    join artists on artists.ArtistID=albums.ArtistID 
where genres.name='Latin' ;

/* TASK III
Which video track has the longest length?
*/
select tracks.Name, max(tracks.Milliseconds) from tracks 
    join media_types on tracks.MediaTypeId=media_types.MediaTypeId  
    where media_types.Name='Protected MPEG-4 video file'
    ;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
select customers.FirstName, customers.LastName from customers 
    join employees on customers.City=employees.City
    where employees.ReportsTo is NULL;

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT boss.* from customers
    join employees on employees.EmployeeId=customers.SupportRepId
    join employees as boss on employees.ReportsTo=boss.EmployeeId
    where customers.Country='Brazil'
    GROUP by boss.EmployeeId;

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.Name from tracks
    JOIN genres on genres.GenreId=tracks.GenreId
    JOIN playlist_track on playlist_track.TrackId=tracks.TrackId
    join playlists on playlist_track.PlaylistId=playlists.PlaylistId
    where genres.Name !='Latin'
    GROUP BY playlists.Name;