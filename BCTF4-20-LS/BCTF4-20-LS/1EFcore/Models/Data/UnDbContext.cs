using _1EFcore.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace _1EFcore.Models.Data
{
    public class UnDbContext : DbContext
    {
        //აქ უწერ ცხრილებს, რომლები უნდა შექმნას
        //Entity-ში შენ გაწერე ეს ცხილრბი, აქ ქმნი პროსტა
        public DbSet<Student> Students { get; set; }
        public DbSet<Courses> Courses { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=DESKTOP-8UGO4GL\\SQLEXPRESS;Database=UNIEF;Integrated Security=True;TrustServerCertificate=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Student>()
                .HasMany(s => s.Courses)
                .WithMany(s => s.Students)
                .UsingEntity(st => st.ToTable("StudentCourses"));
        }

    }
}
