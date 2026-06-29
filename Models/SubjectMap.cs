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
                { "ENG", new SubjectInfo { Table = "bcs_1_ENG", Title = "English" } },
                { "CN", new SubjectInfo { Table = "bcs_1_CN", Title = "Computer Network" } },
                { "POP", new SubjectInfo { Table = "bcs_1_POP", Title = "Principle of Programming" } },
                { "DMP", new SubjectInfo { Table = "bcs_1_DMP", Title = "Discrete Mathematics and Probability" } },
                { "CS", new SubjectInfo { Table = "bcs_1_CS", Title = "Computer Systems" } },

               // BCS - 2nd Semester
               { "CE", new SubjectInfo { Table = "bcs_2_CE", Title = "Computer Ethics" } },
               { "DCN", new SubjectInfo { Table = "bcs_2_DCN", Title = "Data Communication & Networking" } },
               { "OOP", new SubjectInfo { Table = "bcs_2_OOP", Title = "Object Oriented Programming" } },
               { "OS", new SubjectInfo { Table = "bcs_2_OS", Title = "Operating Systems" } },
               { "CO", new SubjectInfo { Table = "bcs_2_CO", Title = "Computer Organization" } },

               // BCS - 3rd Semester
              { "SEF", new SubjectInfo { Table = "bcs_3_SEF", Title = "Software Engineering Fundamentals" } },
              { "HCI", new SubjectInfo { Table = "bcs_3_HCI", Title = "Human Computer Interaction" } },
              { "AS", new SubjectInfo { Table = "bcs_3_AS", Title = "Applied Statistics" } },
              { "WSA", new SubjectInfo { Table = "bcs_3_MWSA", Title = "Microsoft Windows Server Administration" } },
              { "CSLPA", new SubjectInfo { Table = "bcs_3_CSLPA", Title = "Cyber Security Legal Issues & Policy Analysis" } },
              { "CCNA", new SubjectInfo { Table = "bcs_3_CCNA", Title = "Cisco Certified Network Associate" } },

              //BHM
              // BHM - 1st Semester
              { "FOM", new SubjectInfo { Table = "bhm_1_FOM", Title = "Fundamentals of Management" } },
              { "FBM", new SubjectInfo { Table = "bhm_1_FBM", Title = "Food and Beverage Management" } },
              { "FOK", new SubjectInfo { Table = "bhm_1_FOK", Title = "Fundamentals of Kitchen" } },
              { "ENG_I", new SubjectInfo { Table = "bhm_1_EHG_I", Title = "English I" } },
              { "IHTM", new SubjectInfo { Table = "bhm_1_IHTM", Title = "Introduction to Hospitality & Tourism Management" } },
              { "FOM", new SubjectInfo { Table = "bhm_1_FOM", Title = "Front Office Management" } },

               // BHM - 2nd Semester
              { "HKM", new SubjectInfo { Table = "bhm_1_HKM", Title = "Housekeeping Management" } },
              { "HA", new SubjectInfo { Table = "bhm_1_HA", Title = "Hospitality Accounting" } },
              { "HF", new SubjectInfo { Table = "bhm_1_HF", Title = "Hotel French" } },
              { "ENG_II", new SubjectInfo { Table = "bhm_1_EHG_II", Title = "English II" } },
              { "HHRM", new SubjectInfo { Table = "bhm_1_HHRM", Title = "Hospitality Human Resource Management" } },
              { "FPO", new SubjectInfo { Table = "bhm_1_FPO", Title = "Food Production Operation" } },

              // BHM - 3rd Semester
              { "HTD", new SubjectInfo { Table = "bhm_1_HTD", Title = "Hospitality Training & Development" } },
              { "TT", new SubjectInfo { Table = "bhm_1_TT", Title = "Travel and Tour" } },
              { "HSM", new SubjectInfo { Table = "bhm_1_HSM", Title = "Hospitality Service Management" } },
              { "HM", new SubjectInfo { Table = "bhm_1_HM", Title = "Hospitality Marketing" } },
              { "HRM", new SubjectInfo { Table = "bhm_1_HRM", Title = "Hospitality Revenue Management" } },
              { "CSHI", new SubjectInfo { Table = "bhm_1_CSHI", Title = "Customer Service in Hospitality Industry" } },














               // BCS - 3rd Semester
              { "BCS_SEF", new SubjectInfo { Table = "bcs_3_SEF", Title = "Software Engineering Fundamentals" } },
              { "BCS_HCI", new SubjectInfo { Table = "bcs_3_HCI", Title = "Human Computer Interaction" } },
              { "BCS_AS", new SubjectInfo { Table = "bcs_3_AS", Title = "Applied Statistics" } },
              { "BCS_MWSA", new SubjectInfo { Table = "bcs_3_MWSA", Title = "Microsoft Windows Server Administration" } },
              { "BCS_CSLPA", new SubjectInfo { Table = "bcs_3_CSLPA", Title = "Cyber Security Legal Issues & Policy Analysis" } },
              { "BCS_CCNA", new SubjectInfo { Table = "bcs_3_CCNA", Title = "Cisco Certified Network Associate" } },

            };
    }
}