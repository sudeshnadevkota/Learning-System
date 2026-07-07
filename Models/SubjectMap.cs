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



                //BHM
                // BHM - 1st Semester
                { "BHM_FM", new SubjectInfo { Table = "bhm_1_FM", Title = "Fundamentals of Management" } },
                { "BHM_FBM", new SubjectInfo { Table = "bhm_1_FBM", Title = "Food and Beverage Management" } },
                { "BHM_FOK", new SubjectInfo { Table = "bhm_1_FOK", Title = "Fundamentals of Kitchen" } },
                { "BHM_ENG_1", new SubjectInfo { Table = "bhm_1_ENG_1", Title = "English I" } },
                { "BHM_IHTM", new SubjectInfo { Table = "bhm_1_IHTM", Title = "Introduction to Hospitality & Tourism Management" } },
                { "BHM_FOM", new SubjectInfo { Table = "bhm_1_FOM", Title = "Front Office Management" } },
            
                // BHM - 2nd Semester
                { "BHM_HKM", new SubjectInfo { Table = "bhm_2_HKM", Title = "Housekeeping Management" } },
                { "BHM_HA", new SubjectInfo { Table = "bhm_2_HA", Title = "Hospitality Accounting" } },
                { "BHM_HF", new SubjectInfo { Table = "bhm_2_HF", Title = "Hotel French" } },
                { "BHM_ENG_2", new SubjectInfo { Table = "bhm_2_ENG_2", Title = "English II" } },
                { "BHM_HHRM", new SubjectInfo { Table = "bhm_2_HHRM", Title = "Hospitality Human Resource Management" } },
                { "BHM_FPO", new SubjectInfo { Table = "bhm_2_FPO", Title = "Food Production Operation" } },

                // BHM - 3rd Semester,
                { "BHM_HTD", new SubjectInfo { Table = "bhm_3_HTD", Title = "Hospitality Training & Development" } },
                { "BHM_TT", new SubjectInfo { Table = "bhm_3_TT", Title = "Travel and Tour" } },
                { "BHM_HSM", new SubjectInfo { Table = "bhm_3_HSM", Title = "Hospitality Service Management" } },
                { "BHM_HM", new SubjectInfo { Table = "bhm_3_HM", Title = "Hospitality Marketing" } },
                { "BHM_HRM", new SubjectInfo { Table = "bhm_3_HRM", Title = "Hospitality Revenue Management" } },
                { "BHM_CSIH", new SubjectInfo { Table = "bhm_3_CSIH", Title = "Customer Service in Hospitality Industry" } },

                //MBA 
                //1st Semester
                { "ACC", new SubjectInfo { Table = "mba_1_ACC", Title = "Business Accounting & Finance" } },
                { "ECO", new SubjectInfo { Table = "mba_1_ECO", Title = "Business Economics" } },
                { "HRM", new SubjectInfo { Table = "mba_1_HRM", Title = "Human Resource Management" } },
                { "MC", new SubjectInfo { Table = "mba_1_MC", Title = "Managerial Communications" } },
                { "BEA", new SubjectInfo { Table = "mba_1_BEA", Title = "Business Environment Analysis" } },

                // 2nd Semester
                { "RM", new SubjectInfo { Table = "mba_2_RM", Title = "Research Methodology" } },
                { "OM", new SubjectInfo { Table = "mba_2_OM", Title = "Operation Management" } },
                { "MM", new SubjectInfo { Table = "mba_2_MM", Title = "Marketing Management" } },
                { "OB", new SubjectInfo { Table = "mba_2_OB", Title = "Organizational Behavior" } },

                // 3rd Semester
                { "SM", new SubjectInfo { Table = "mba_3_SM", Title = "Strategic Management" } },
                { "FM", new SubjectInfo { Table = "mba_3_FM", Title = "Financial Management" } },{ "EM", new SubjectInfo { Table = "mba_3_EM", Title = "Entrepreneurship Management" } },
                { "SPM", new SubjectInfo { Table = "mba_3_SPM", Title = "Sales & Promotions Management" } },
                { "IB", new SubjectInfo { Table = "mba_3_IB", Title = "International Business" } },
                { "HRD", new SubjectInfo { Table = "mba_3_HRD", Title = "Human Resource Development & Leadership" } },

                // 4th Semester
                { "BI", new SubjectInfo { Table = "mba_4_BI", Title = "Banking & Insurance" } },
                { "CRM", new SubjectInfo { Table = "mba_4_CRM", Title = "Customer Relationship Management" } },
                { "CMN", new SubjectInfo { Table = "mba_4_CMN", Title = "Conflict Management & Negotiation Skills" } },
                { "MOD", new SubjectInfo { Table = "mba_4_MOD", Title = "Management of Data" } },
                { "BEG", new SubjectInfo { Table = "mba_4_BEG", Title = "Business Ethics & Governance" } },
                { "GRP", new SubjectInfo { Table = "mba_4_GRP", Title = "Graduate Research Project Paper" } },



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
