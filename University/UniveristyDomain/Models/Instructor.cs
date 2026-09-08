using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UniveristyDomain.Models
{
    public class Instructor
    {

        //კონსტრუქტორი აიდის გარეშე
        public Instructor(string firstName, string lastName, string email)
        {
            this.FirstName = firstName;
            this.LastName = lastName;
            this.Email = email;
        }

        //კონსტრუქტორი აიდით
        public Instructor(int instructorID, string firstName, string lastName, string email)
        {
            this.InstructorID = instructorID;
            this.FirstName = firstName;
            this.LastName = lastName;
            this.Email = email;
        }
        public int InstructorID{ get; set; }
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string Email {  get; set; }

        public override string ToString()
        {
            return $"InstructorID - {InstructorID}, FirstName - {FirstName}, LastName - {LastName}, Email - {Email}";
        }

    }
}
