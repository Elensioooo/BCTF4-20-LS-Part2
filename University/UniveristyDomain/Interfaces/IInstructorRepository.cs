using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Models;

namespace UniveristyDomain.Interfaces
{
    public interface IInstructorRepository
    {

        IEnumerable<Instructor> GetAllInstructors();
        Instructor GetInstructorById(int id);
        bool AddInstructor(Instructor instructor);
        bool DeleteInstructor(Instructor instructor);

        bool UpdateInstructor(Instructor instructor);
    }
}
