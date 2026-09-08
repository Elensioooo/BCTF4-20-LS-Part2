using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Models;

namespace UniveristyDomain.Interfaces
{
    public interface IStudentRepository
    {
        IEnumerable<Student> GetAll();
        Student GetById(int id);
        
        
        //მონაცემთა ბაზაში რომ ვამატებთ რამეს იქედან მოდის რაოდენობა, თუ რამდენი row შეიცვალა
        //row effect countს აბრუნებს. თუ შეიცვალა true, თუ არ შეიცვალ false
        bool Add(Student student);
    }
}
