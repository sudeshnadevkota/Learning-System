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

                //BCS 
                //1st semester subjects
                // BCS - 1st Semester
                { "BCS_ENG", new SubjectInfo { Table = "bcs_1_ENG", Title = "English" } },
                { "BCS_CN", new SubjectInfo { Table = "bcs_1_CN", Title = "Computer Network" } },
                { "BCS_POP", new SubjectInfo { Table = "bcs_1_POP", Title = "Principle of Programming" } },
                { "BCS_DMP", new SubjectInfo { Table = "bcs_1_DMP", Title = "Discrete Mathematics and Probability" } },
                { "BCS_CS", new SubjectInfo { Table = "bcs_1_CS", Title = "Computer Systems" } },
 
                // BCS - 2nd Semester
                { "BCS_CE", new SubjectInfo { Table = "bcs_2_CE", Title = "Computer Ethics" } },
                { "BCS_DCN", new SubjectInfo { Table = "bcs_2_DCN", Title = "Data Communication & Networking" } },
                { "BCS_OOP", new SubjectInfo { Table = "bcs_2_OOP", Title = "Object Oriented Programming" } },
                { "BCS_OS", new SubjectInfo { Table = "bcs_2_OS", Title = "Operating Systems" } },
                { "BCS_CO", new SubjectInfo { Table = "bcs_2_CO", Title = "Computer Organization" } },

                // BCS - 3rd Semester
                { "BCS_SEF", new SubjectInfo { Table = "bcs_3_SEF", Title = "Software Engineering Fundamentals" } },
                { "BCS_HCI", new SubjectInfo { Table = "bcs_3_HCI", Title = "Human Computer Interaction" } },
                { "BCS_AS", new SubjectInfo { Table = "bcs_3_AS", Title = "Applied Statistics" } },
                { "BCS_MWSA", new SubjectInfo { Table = "bcs_3_MWSA", Title = "Microsoft Windows Server Administration" } },
                { "BCS_CSLPA", new SubjectInfo { Table = "bcs_3_CSLPA", Title = "Cyber Security Legal Issues & Policy Analysis" } },
                { "BCS_CCNA", new SubjectInfo { Table = "bcs_3_CCNA", Title = "Cisco Certified Network Associate" } },

                //BBA
                // BBA - 1st Semester
                { "BBA_ENG_I", new SubjectInfo { Table = "bba_1_ENG_I", Title = "English I" } },
                { "BBA_EPP", new SubjectInfo { Table = "bba_1_EPP", Title = "English for Professional Purposes" } },
                { "BBA_POM", new SubjectInfo { Table = "bba_1_POM", Title = "Principles of Management" } },
                { "BBA_IA", new SubjectInfo { Table = "bba_1_IA", Title = "Introduction to Accounting" } },
                { "BBA_FCPP", new SubjectInfo { Table = "bba_1_FCPP", Title = "Fundamental Computer Principles & Programming" } },

                // BBA - 2nd Semester
                { "BBA_HRM", new SubjectInfo { Table = "bba_2_HRM", Title = "Human Resource Management" } },
                { "BBA_POF", new SubjectInfo { Table = "bba_2_POF", Title = "Principles of Marketing" } },
                { "BBA_IFA", new SubjectInfo { Table = "bba_2_IFA", Title = "Internet Fundamentals & Applications" } },
                { "BBA_E", new SubjectInfo { Table = "bba_2_E", Title = "Entrepreneurship" } },
                { "BBA_ENG_II", new SubjectInfo { Table = "bba_2_ENG_II", Title = "English II" } },

                // BBA - 3rd Semester
                { "BBA_S", new SubjectInfo { Table = "bba_3_S", Title = "Sociology" } },
                { "BBA_BO", new SubjectInfo { Table = "bba_3_BO", Title = "Business Organization" } },
                { "BBA_BL", new SubjectInfo { Table = "bba_3_BL", Title = "Business Law" } },
                { "BBA_HRLS", new SubjectInfo { Table = "bba_3_HRLS", Title = "Human Relations and Leadership Skills" } },
                { "BBA_M", new SubjectInfo { Table = "bba_3_M", Title = "Microeconomics" } },
                { "BBA_PM", new SubjectInfo { Table = "bba_3_PM", Title = "Project Management" } },



            };
    }
}