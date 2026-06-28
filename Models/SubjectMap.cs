using System;
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
    new Dictionary<string, SubjectInfo>(StringComparer.OrdinalIgnoreCase)
            {
                { "BE", new SubjectInfo { Table = "bit_1_BE", Title = "Business English" } },
                { "ICP", new SubjectInfo { Table = "bit_1_ICP", Title = "Introduction to C++ Programming" } },
                { "BCA", new SubjectInfo { Table = "bit_1_BCA", Title = "Basic Computer Architecture" } },
                { "Math", new SubjectInfo { Table = "bit_1_Math", Title = "Computer Related Mathematics and Statics" } },
                { "PIT", new SubjectInfo { Table = "bit_1_PIT", Title = "Principle of Information Technology" } },
                // Add more subjects below, same pattern:
                // { "DSA", new SubjectInfo { Table = "bit_1_DSA", Title = "Data Structures and Algorithms" } },

                //2nd semester subjects
                { "HCI", new SubjectInfo { Table = "bit_2_HCI", Title = "Human Computer Interaction" } },
                { "DM", new SubjectInfo { Table = "bit_2_DM", Title = "Discrete Mathematics" } },
                { "DCN", new SubjectInfo { Table = "bit_2_DCN", Title = "Data Communication and Networks" } },
                { "OOP", new SubjectInfo { Table = "bit_2_OOP", Title = "Object Oriented Programming" } },
                { "OS", new SubjectInfo { Table = "bit_2_OS", Title = "Operating System" } },



                //3rd semester subjects
                { "DELD", new SubjectInfo { Table = "bit_3_DELD", Title = "Digital Electronics and Logic Design " } },
                { "DSA", new SubjectInfo { Table = "bit_3_DSA", Title = "Data Structure & Algorithm " } },
                { "IM", new SubjectInfo { Table = "bit_3_IM", Title = "Industrial Management" } },
                { "WT", new SubjectInfo { Table = "bit_3_WT", Title = "Web Technology" } },
                { "LA", new SubjectInfo { Table = "bit_3_LA", Title = "Linux Administration" } },
                { "DMS", new SubjectInfo { Table = "bit_3_DMS", Title = "Database Management System" } },





                //MCS subjects
                //1st semester subjects
                { "MCS_OOP", new SubjectInfo { Table = "mcs_1_OOP", Title = "Object Oriented Programming" } },
                { "MCS_AC", new SubjectInfo { Table = "mcs_1_AC", Title = "Algorithms And Complexity" } },
                { "MCS_HPN", new SubjectInfo { Table = "mcs_1_HPN", Title = "High Performance Network" } },
                { "MCS_IPWD", new SubjectInfo { Table = "mcs_1_IPWD", Title = "Internet Programming and Web Design" } },

                // 2nd semester subjects
                { "MCS_TS", new SubjectInfo { Table = "mcs_2_TS", Title = "Telecommunication Systems" } },
                { "MCS_IS", new SubjectInfo { Table = "mcs_2_IS", Title = "Information Security" } },
                { "MCS_AJ", new SubjectInfo { Table = "mcs_2_AJ", Title = "Advanced Java" } },
                { "MCS_AI", new SubjectInfo { Table = "mcs_2_AI", Title = "Artificial Intelligence" } },


                // 3rd semester subjects
                { "MCS_ADB", new SubjectInfo { Table = "mcs_3_ADB", Title = "Advanced Database" } },
                { "MCS_RM", new SubjectInfo { Table = "mcs_3_RM", Title = "Research Methodology" } },
                { "MCS_CC", new SubjectInfo { Table = "mcs_3_CC", Title = "Cloud Computing" } },
                { "MCS_AAIES", new SubjectInfo { Table = "mcs_3_AAIES", Title = "Advanced AI With Expert System" } },

                // 4th semester subjects
                { "MCS_PP", new SubjectInfo { Table = "mcs_4_PP", Title = "Project Paper" } },
                { "MCS_SEIIT", new SubjectInfo { Table = "mcs_4_SEIIT", Title = "Seminar in Emerging Issues in IT" } },


            };
    }
}
