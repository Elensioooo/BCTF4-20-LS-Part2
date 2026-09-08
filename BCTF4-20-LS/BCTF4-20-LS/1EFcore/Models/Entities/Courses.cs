using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1EFcore.Models.Entities
{
    public class Courses
    {
        public int Id { get; set; }
        [Required]
        [MaxLength(100)]
        public string Title { get; set; }

        //რელაცია როგორი იქნება თვითნ ხვდება(ეს არის ბევრი ბევრთან)
        public ICollection<Student> Students { get; set; }
    }
}
