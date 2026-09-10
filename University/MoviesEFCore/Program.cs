using MoviesEFCore.Data;
using MoviesEFCore.Models.Entities;

namespace MoviesEFCore
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var context = new MovieDbContext(); // ობიექტი დატა ფოლდერის MovieDbContext-ის კლასის
            context.Database.EnsureCreated(); //ამით კეთდება მიგრაციები. ეს შექმნის ცხრილებს და გააკეთბს კავშირებს

            
            Country country1 = new Country();
            country1.Name = "USA";
            //country and studio relations
            country1.Studios = new List<Studio>();


            Studio studio1 = new Studio();
            studio1.Name = "Walt Disney";
            //studio and country relation
            studio1.Country = country1;
            //studion and movie relation
            studio1.Movies = new List<Movie>();
            

            StudioDetails studioDetails1 = new StudioDetails();
            studioDetails1.LicenseNumber = "1234567894abc";
            //studio and stuiod details relation
            studioDetails1.Studio = studio1;
            //studioDetails and studio relation
            studio1.StudioDetails = studioDetails1;

            Movie movie1 = new Movie();
            movie1.Title = "Coco";
            movie1.ReleaseYear = 2017;
            movie1.Studio = studio1;
            //movie and actors relation
            movie1.Actors = new List<Actor>();

            Actor actor1 = new Actor();
            actor1.FirstName = "Anthony";
            actor1.LastName = "Gonzalez";
            //actors and movies lreaitons
            actor1.Movies = new List<Movie>();


            country1.Studios.Add(studio1);
            studio1.Movies.Add(movie1);
            movie1.Actors.Add(actor1);
            actor1.Movies.Add(movie1);

            context.Countries.Add(country1);
            context.SaveChanges();
        }
    }
}
