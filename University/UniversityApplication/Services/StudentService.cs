using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Interfaces;
using UniveristyDomain.Models;

namespace UniversityApplication.Services
{
    public class StudentService
    {
        private readonly IStudentRepository _studentRepository;
        public StudentService(IStudentRepository studentRepository)
        {
            _studentRepository = studentRepository;
        }


        public IEnumerable<Student> GetAllStudents()
        {
            var students = _studentRepository.GetAll();
            return students;
        }
        public Student GetById(int id)
        {
            var studentById = _studentRepository.GetById(id);
            if (studentById == null)
                throw new ArgumentException("Student with this id cannot be found");
            return studentById;
        }

        public bool Add(Student student)
        {
            if (student == null)
                throw new ArgumentNullException("Student cannot be empty");
            if(_studentRepository.Add(student))
                return true;
            return false;
        }
    }
}
