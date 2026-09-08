using Microsoft.Data.SqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using System.Reflection.PortableExecutable;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using UniveristyDomain.Interfaces;
using UniveristyDomain.Models;

namespace UniversityInfrastructure_.Repositories
{
    public class InstructorRepository : IInstructorRepository
    {
        private readonly string _connectionString;
        public InstructorRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

         public IEnumerable<Instructor> GetAllInstructors()
         {
            var instructors = new List<Instructor>();
            var query = "SELECT * FROM INSTRUCTORS";
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            connection.Open();
            using var reader = command.ExecuteReader();

            while (reader.Read())
            {
                if (reader.HasRows)
                {
                    Instructor newInstructor = MapInstructor(reader);
                    instructors.Add(newInstructor);
                }
            }

            return instructors;
         }

        public Instructor GetInstructorById(int id)
        {
            var query = "SELECT * FROM INSTRUCTORS WHERE InstructorID = @id";
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            
            command.Parameters.AddWithValue("@Id", id);
            connection.Open();
            using var reader = command.ExecuteReader();

            if (reader.Read())
            {
                var instructor = MapInstructor(reader);
                return instructor;
            }
            return null;
        }

        public bool AddInstructor(Instructor instructor)
        {
            var query = "sp_AddInstructor";
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@FirstName", instructor.FirstName);
            command.Parameters.AddWithValue("@LastName", instructor.LastName);
            command.Parameters.AddWithValue("@EMAIL", instructor.Email);
            connection.Open();

            if (command.ExecuteNonQuery() > 0)
                return true;
            return false;
        }

        public bool DeleteInstructor(Instructor instructor)
        {
            var query = "DELETE FROM INSTRUCTORS WHERE InstructorID = @ID";
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Id", instructor.InstructorID);
            connection.Open();

            if (command.ExecuteNonQuery() > 0)
                return true;
         
            return false;
        }


        public bool UpdateInstructor(Instructor instructor)
        {
            var query = "sp_UpdateInstructor";
            using var connection = new SqlConnection(_connectionString);
            using var command = new SqlCommand(query, connection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@InstructorID", instructor.InstructorID);
            command.Parameters.AddWithValue("@FirstName", instructor.FirstName);
            command.Parameters.AddWithValue("@LastName", instructor.LastName);
            command.Parameters.AddWithValue("@EMAIL", instructor.Email);
            connection.Open();

            if (command.ExecuteNonQuery() > 0)
                return true;

            return false;
        }


        private Instructor MapInstructor(SqlDataReader reader)
        {
            return new Instructor
            (
                reader.GetInt32(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetString(3)
            );
        }
    }
}


