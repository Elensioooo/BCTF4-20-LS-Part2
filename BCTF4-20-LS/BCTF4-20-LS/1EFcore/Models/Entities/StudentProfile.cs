using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1EFcore.Models.Entities
{
    public class StudentProfile
    {
        public int Id { get; set; }
        public string Address {  get; set; }

        public int StudentId { get; set; }
        public Student Student { get; set; }
    }
}
