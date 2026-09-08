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

            //ყველა სტუდენტის გამოტანა
            studentService.GetAllStudents();
            //StudentService.GetById(1);
            //აქ ვიძახებ იმ კონკსტრუქტორს, რომელსაც აიდი არ აქვს. ანუ დასამატებლად გასაკეთბელ კონსტრუქტორს
            Student newStudent = new Student("გიორგი", "giorgi.beridze@gmail.com", 23, 3.75m, true, new DateTime(2026, 8, 29), "555123789", 5);
            bool result = studentService.Add(newStudent);
            Console.WriteLine(result); // ჩაემატა


        }

    }
}
