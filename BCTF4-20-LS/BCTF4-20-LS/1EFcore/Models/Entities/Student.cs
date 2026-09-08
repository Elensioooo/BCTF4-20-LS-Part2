using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1EFcore.Models.Entities
{
    public class Student
    {
        //ესენი ყველა არის  ცხრილი ქოლუმნები
        public int Id { get; set; } // default-ად ხვდება რომ id იქნება primary key
        [Required]
        [MaxLength(100)]
        public string FirstName { get; set; }
        [Required]
        [MaxLength(100)]
        public string LastName { get; set; }
        public string Email {  get; set; }
        public string Phone { get; set; }
        public int Age { get; set; }
        public decimal GPA { get; set; }

        public ICollection<Courses> Courses { get; set; } 
    }
}
