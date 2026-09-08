using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UniveristyDomain.Models
{
    public class Student
    {

        //ეს კონსტრუქტორი მაშინ როცა ბაზიდან მომაქვს სტუდენტი
        public Student(int iD,string firstName, string email, int age, decimal? GPA, bool? isActive, DateTime? registered, string? phoneNumber, int? facutlyId)
        {
            this.ID = iD;
            this.FirstName = firstName;
            this.Email = email;
            this.Age = age;
            this.GPA = GPA;
            this.IsActive = isActive;
            this.Registered = registered;
            this.PhoneNumber = phoneNumber;
            this.FacutlyId = facutlyId;
        }

        //ახალი სტუდენტის დასამატებლად 
        public Student(string firstName, string email, int age, decimal? gPA, bool? isActive, DateTime? registered, string? phoneNumber, int? facutlyId)
        {
            FirstName = firstName;
            Email = email;
            Age = age;
            GPA = gPA;
            IsActive = isActive;
            Registered = registered;
            PhoneNumber = phoneNumber;
            FacutlyId = facutlyId;
        }

        public int ID { get; set; }
        public string FirstName { get; set; }
        public string Email { get; set; }
        public int Age { get; set; }
        public decimal? GPA { get; set; }
        public bool? IsActive { get; set;}

        public DateTime? Registered { get; set; }
        public string? PhoneNumber { get; set; }
        public int? FacutlyId { get; set; }


        public override string ToString()
        {
            return $"Id: {ID}, FirstName: {FirstName}, Email: {Email}, Age: {Age}, GPA: " +
                $"{GPA}, IsActive: {IsActive}, RegisteredDate: {Registered}, FacutlyId: {FacutlyId}";
        }
    }
}
