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
                // Add more subjects below, same pattern:
                // { "DSA", new SubjectInfo { Table = "bit_1_DSA", Title = "Data Structures and Algorithms" } },
            };
    }
}