using Microsoft.Data.SqlClient;
using System.Text;

namespace _1ADONet
{
    internal class Program
    {
        private static readonly string _connectionString = "Data Source=DESKTOP-8UGO4GL\\SQLEXPRESS;Database=UNIVERSITY;Integrated Security=True;TrustServerCertificate=True;";
        static void Main(string[] args)
        {
            Console.InputEncoding = Encoding.UTF8;
            Console.OutputEncoding = Encoding.UTF8;
            ReadStudentsAllData();
        }

        static void ReadStudentsAllData()
        {
            // FLOW:
            // 1. Create a connection
            // 2. Open the connection
            // 3. Create a SQL command
            // 4. Execute the command
            // 5. Read all returned rows
            // 6. Get the required data from each row
            // 7. Display the data
            //USING - დახურვა რომ არ დამჭირდეს მაგისთვის ვიყენებ 
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                //string query = ;
                using (SqlCommand command = new SqlCommand("SELECT * FROM Students", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader()) // ExecuteReader - ბრძანების გაშვება. ანუ execute click
                    {
                        while (reader.Read()) 
                        {
                            if (reader.HasRows)
                            {
                                //int id = reader.GetInt32("ID");
                                //string name = reader.GetString("Name");

                                int id = (int)reader["ID"];
                                string name = (string)reader["FirstName"];

                                Console.WriteLine($"ID: {id}, Name: {name}");
                            }
                        }
                    }
                }
            }
        }
    }
}
