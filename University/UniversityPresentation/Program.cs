using UniveristyDomain.Interfaces;
using UniversityInfrastructure_.Repositories;
using UniversityApplication.Services;
using UniveristyDomain.Models;
namespace UniversityPresentation
{
    internal class Program
    {
        private static readonly string _connectionString = "Data Source=DESKTOP-8UGO4GL\\SQLEXPRESS;Database=UNIVERSITY;Integrated Security=True;TrustServerCertificate=True;";
        //todo - ეს შეინახება კონფიგურაციის ფაილში(appsettings.json) და მერე შემოვიტანთ 
        static void Main(string[] args)
        {
            IStudentRepository studentRepository = new StudentRepository(_connectionString);
            StudentService studentService = new StudentService(studentRepository);

            IInstructorRepository instructorRepository = new InstructorRepository(_connectionString);
            InstructorService instructorService = new InstructorService(instructorRepository);

            //ყველა სტუდენტის გამოტანა
            var students = studentService.GetAllStudents();
            foreach (var student in students)
            {
                Console.WriteLine(student.ToString());
            }
            //StudentService.GetById(1);
            //აქ ვიძახებ იმ კონკსტრუქტორს, რომელსაც აიდი არ აქვს. ანუ დასამატებლად გასაკეთბელ კონსტრუქტორს
            //Student newStudent = new Student("გიორგი", "giorgi.beridze@gmail.com", 23, 3.75m, true, new DateTime(2026, 8, 29), "555123789", 5);
            //bool result = studentService.Add(newStudent);
            //Console.WriteLine(result); // ჩაემატა


            //ყველა ინსტრუქტორი
            var instructors = instructorService.GetAllInstructors();
            foreach(var instructor in instructors)
            {
                Console.WriteLine(instructor.ToString());
            }

            Instructor instructor5 = new Instructor(6, "Giorgi", "barbaqadze", "gio@gmail.com");
            instructorService.UpdateInstructor(instructor5);
            instructorService.DeleteInstructor(instructor5);//მგონი ჯობია რომ მეთოდი დავამატო, სადაც აიდით წაშლის ინსტრუქტორს

        }

    }
}
