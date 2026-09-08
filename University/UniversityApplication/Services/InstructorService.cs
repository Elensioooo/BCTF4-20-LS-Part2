using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Interfaces;
using UniveristyDomain.Models;

namespace UniversityApplication.Services
{
    public class InstructorService
    {
        private readonly IInstructorRepository _instructorRepository;
        
        public InstructorService(IInstructorRepository instructorRepository)
        {
            _instructorRepository = instructorRepository;
        }

        public IEnumerable<Instructor> GetAllInstructors()
        {
            var instructors = _instructorRepository.GetAllInstructors();
            return instructors;
        }

        public Instructor GetInstructorById(int id)
        {
            if (id <= 0)
                throw new ArgumentException("id cannot be negative or 0");
            var instructorById = _instructorRepository.GetInstructorById(id);
            if (instructorById == null)
                throw new ArgumentException("Instructor with this id cannot be found");
            return instructorById;
        }

        public bool AddInstructor(Instructor instructor)
        {
            if (instructor == null)
                throw new ArgumentNullException("Insgructor cannot be empty");
            if (_instructorRepository.AddInstructor(instructor))
                return true;
            return false;
        }

        public bool DeleteInstructor(Instructor instructor)
        {
            if (instructor == null)
                throw new ArgumentNullException("Insgructor cannot be empty");
            if (_instructorRepository.DeleteInstructor(instructor))
                return true;
            return false;
        }

        public bool UpdateInstructor(Instructor instructor)
        {
            if (instructor == null)
                throw new ArgumentNullException("Insgructor cannot be empty");
            if(_instructorRepository.UpdateInstructor(instructor))
                return true;
            return false;
        }
    }
}
