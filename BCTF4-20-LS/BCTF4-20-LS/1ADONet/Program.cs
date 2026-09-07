using Microsoft.Data.SqlClient;
using System.Text;

namespace _1ADONet
{
    internal class Program
    {
        private static readonly string _connectionString = "Data Source=DESKTOP-8UGO4GL\\SQLEXPRESS;Database=UNIVERSITY;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Application Name=\"SQL Server Management Studio\";Command Timeout=0";
        static void Main(string[] args)
        {
            Console.InputEncoding = Encoding.UTF8;
            Console.OutputEncoding = Encoding.UTF8;
            ReadStudentsAllData();
        }

        static void ReadStudentsAllData()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                //string query = ;
                using (SqlCommand command = new SqlCommand("SELECT * FROM Students", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            if (reader.HasRows)
                            {
                                //int id = reader.GetInt32("ID");
                                //string name = reader.GetString("Name");

                                int id = (int)reader["ID"];
                                string name = (string)reader["Name"];

                                Console.WriteLine($"ID: {id}, Name: {name}");
                            }
                        }
                    }
                }
            }
        }
    }
}
