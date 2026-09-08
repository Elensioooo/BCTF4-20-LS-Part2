using _1EFcore.Models.Data;
using _1EFcore.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace _1EFcore
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //code first(არ მაქვს ბაზა გამზადებული, აქედან ვწერ ყველადერს)


            var context = new UnDbContext();
            context.Database.EnsureCreated();//ესენი მიგრაციებით ჩანაცვლდება

            var newCoarse = new Courses{ Title = "IT Support" };
            var newStudent = new Student
            {
                FirstName = "John",
                LastName = "Doe",
                Email = "DOE@gmail.com",
                Phone = "123456789",
                Age = 20,
                GPA = 3.2M,
                Courses = new List<Courses> { newCoarse }
            };

            //context.Courses.Add(newCoarse);
            //context.Students.Add(newStudent);
            //context.SaveChanges();



            //var studetnsAll = context.Students
            //    .Include(s => s.Courses)
            //    .ToList();

            foreach(var item in studentsAll)
            {

            }
        }
    }
}
