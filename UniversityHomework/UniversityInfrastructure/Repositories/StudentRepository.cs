using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection.PortableExecutable;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Interfaces;
using UniveristyDomain.Models;

namespace UniversityInfrastructure_.Repositories
{
    public class StudentRepository : IStudentRepository
    {
        private readonly string _connectionString;
        public StudentRepository(string connectionString) 
        { 
            _connectionString = connectionString;
        
        }
        public IEnumerable<Student> GetAll()
        {
            var students = new List<Student>();

            //QUERY - რა ბრძანება მიდნა 
            var query = "SELECT * FROM STUDENTS";

            //ავაწყოთ ქონექშენი - ანუ რომელ ბაზასთან ვმუშაობ
            using var connection = new SqlConnection(_connectionString);

            //command - ამ ბრძანებას ვასრუელაბ ამ ქონექშენზე
            using var command = new SqlCommand(query, connection);

            //connection გავხსნათ
            connection.Open();
            //command.ExecuteReader(); ეს პროსტა უშვებს ჩემს ბრძანებას და რიდერში ვინახავ შედეგს
            using var reader = command.ExecuteReader();

            while (reader.Read())
            {
                if (reader.HasRows)
                {
                    Student student = MapStudent(reader);
                    students.Add(student);
                }
            }
            return students;
        }
        public Student GetById(int id)
        {
            var query = "SELECT * FROM STUDENTS WHERE ID = @id";

            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Id", id);
            connection.Open();
            using var reader = command.ExecuteReader();

            if (reader.HasRows)
            {
                var student = MapStudent(reader);
                return student;
            }
            return null;
        }


        public bool Add(Student student)
        {
            var query = "sp_AddStudent";

            //homework part1
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            
            //ამას ვუწერთ იმიტომ, რომ პროცედურა არის ჩვენი ამჟამინდელი კომანდი
            //დეფოლთად სტრინგი არი და მანამდე მაგიტო არ ვუწერდით
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@FirstName", student.FirstName);
            command.Parameters.AddWithValue("@Age", student.Age);
            command.Parameters.AddWithValue("@Email", student.Email);
            command.Parameters.AddWithValue("@GPA", student.GPA);
            command.Parameters.AddWithValue("@IsActive", student.IsActive);
            command.Parameters.AddWithValue("@Registered", student.Registered);
            command.Parameters.AddWithValue("@phoneNumber", student.PhoneNumber);
            command.Parameters.AddWithValue("@FacutlyID", student.FacutlyId);

            connection.Open();
            //command.ExecuteNonQuery() - ეს ბრძანება მეუბენბა რმადენ ROW-ზე იმოქმედა ბრძანებამ(ტიპი არის INT)
            if (command.ExecuteNonQuery() > 0)
                return true; // ჩაემატა სტუდენტი
            return false;
        }

        private Student MapStudent(SqlDataReader reader)
        {
            return new Student
            (
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetInt32(3),
                reader.IsDBNull(4) ? null : reader.GetDecimal(4),
                reader.IsDBNull(5) ? null : reader.GetBoolean(5),
                reader.IsDBNull(6) ? null : reader.GetDateTime(6),
                reader.IsDBNull(7) ? null : reader.GetString(7),
                reader.IsDBNull(8) ? null : reader.GetInt32(8)
            );
        }
    }
}
