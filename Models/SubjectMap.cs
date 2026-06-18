using System.Collections.Generic;

namespace Learning_System
{
    public static class SubjectMap
    {
        public class SubjectInfo
        {
            public string Table { get; set; }
            public string Title { get; set; }
        }

        public static readonly Dictionary<string, SubjectInfo> Subjects =
            new Dictionary<string, SubjectInfo>
            {
                { "BE", new SubjectInfo { Table = "bit_1_BE", Title = "Business English" } },
                { "C++", new SubjectInfo { Table = "bit_1_C++", Title = "Introduction to C++ Programming" } },
                { "BCA", new SubjectInfo { Table = "bit_1_BCA", Title = "Basic Computer Architecture" } },
                { "Math", new SubjectInfo { Table = "bit_1_Math", Title = "Computer Related Mathematics and Statics" } },
                { "P-IT", new SubjectInfo { Table = "bit_1_BE", Title = "Principle of Information Technology" } },
                // Add more subjects below, same pattern:
                // { "DSA", new SubjectInfo { Table = "bit_1_DSA", Title = "Data Structures and Algorithms" } },
            };
    }
}