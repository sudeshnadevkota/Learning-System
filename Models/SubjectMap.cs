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
            public string DepartmentCode { get; set; }
            public int Semester { get; set; } // NEW — derived from Table, e.g. "bit_3_DSA" -> 3
        }

        public static readonly Dictionary<string, SubjectInfo> Subjects =
    new Dictionary<string, SubjectInfo>(StringComparer.OrdinalIgnoreCase)
            {
                { "BE", new SubjectInfo { Table = "bit_1_BE", Title = "Business English", DepartmentCode = "BIT" } },
                { "ICP", new SubjectInfo { Table = "bit_1_ICP", Title = "Introduction to C++ Programming", DepartmentCode = "BIT" } },
                { "BCA", new SubjectInfo { Table = "bit_1_BCA", Title = "Basic Computer Architecture", DepartmentCode = "BIT" } },
                { "Math", new SubjectInfo { Table = "bit_1_Math", Title = "Computer Related Mathematics and Statics", DepartmentCode = "BIT" } },
                { "PIT", new SubjectInfo { Table = "bit_1_PIT", Title = "Principle of Information Technology", DepartmentCode = "BIT" } },

                //2nd semester subjects
                { "HCI", new SubjectInfo { Table = "bit_2_HCI", Title = "Human Computer Interaction", DepartmentCode = "BIT" } },
                { "DM", new SubjectInfo { Table = "bit_2_DM", Title = "Discrete Mathematics", DepartmentCode = "BIT" } },
                { "DCN", new SubjectInfo { Table = "bit_2_DCN", Title = "Data Communication and Networks", DepartmentCode = "BIT" } },
                { "OOP", new SubjectInfo { Table = "bit_2_OOP", Title = "Object Oriented Programming", DepartmentCode = "BIT" } },
                { "OS", new SubjectInfo { Table = "bit_2_OS", Title = "Operating System", DepartmentCode = "BIT" } },

                //3rd semester subjects
                { "DELD", new SubjectInfo { Table = "bit_3_DELD", Title = "Digital Electronics and Logic Design ", DepartmentCode = "BIT" } },
                { "DSA", new SubjectInfo { Table = "bit_3_DSA", Title = "Data Structure & Algorithm ", DepartmentCode = "BIT" } },
                { "IM", new SubjectInfo { Table = "bit_3_IM", Title = "Industrial Management", DepartmentCode = "BIT" } },
                { "WT", new SubjectInfo { Table = "bit_3_WT", Title = "Web Technology", DepartmentCode = "BIT" } },
                { "LA", new SubjectInfo { Table = "bit_3_LA", Title = "Linux Administration", DepartmentCode = "BIT" } },
                { "DMS", new SubjectInfo { Table = "bit_3_DMS", Title = "Database Management System", DepartmentCode = "BIT" } },

                //4th semester subjects

                { "VP", new SubjectInfo { Table = "bit_4_VP", Title = "Visual Programming", DepartmentCode = "BIT" } },
                { "SAD", new SubjectInfo { Table = "bit_4_SAD", Title = "System Analysis & Design", DepartmentCode = "BIT" } },
                { "BIT_OB", new SubjectInfo { Table = "bit_4_OB", Title = "Organizational Behavior", DepartmentCode = "BIT" } }, // Fixed Key
                { "ISS", new SubjectInfo { Table = "bit_4_ISS", Title = "Information System Security", DepartmentCode = "BIT" } },
                { "CMS", new SubjectInfo { Table = "bit_4_CMS", Title = "CMS based E Commerce", DepartmentCode = "BIT" } },
                { "AI", new SubjectInfo { Table = "bit_4_AI", Title = "Artificial Intelligence", DepartmentCode = "BIT" } },

                // BCS - 1st Semester
                { "BCS_ENG", new SubjectInfo { Table = "bcs_1_ENG", Title = "English", DepartmentCode = "BCS" } },
                { "BCS_CN", new SubjectInfo { Table = "bcs_1_CN", Title = "Computer Network", DepartmentCode = "BCS" } },
                { "BCS_POP", new SubjectInfo { Table = "bcs_1_POP", Title = "Principle of Programming", DepartmentCode = "BCS" } },
                { "BCS_DMP", new SubjectInfo { Table = "bcs_1_DMP", Title = "Discrete Mathematics and Probability", DepartmentCode = "BCS" } },
                { "BCS_CS", new SubjectInfo { Table = "bcs_1_CS", Title = "Computer Systems", DepartmentCode = "BCS" } },

                // BCS - 2nd Semester
                { "BCS_CE", new SubjectInfo { Table = "bcs_2_CE", Title = "Computer Ethics", DepartmentCode = "BCS" } },
                { "BCS_DCN", new SubjectInfo { Table = "bcs_2_DCN", Title = "Data Communication & Networking", DepartmentCode = "BCS" } },
                { "BCS_OOP", new SubjectInfo { Table = "bcs_2_OOP", Title = "Object Oriented Programming", DepartmentCode = "BCS" } },
                { "BCS_OS", new SubjectInfo { Table = "bcs_2_OS", Title = "Operating Systems", DepartmentCode = "BCS" } },
                { "BCS_CO", new SubjectInfo { Table = "bcs_2_CO", Title = "Computer Organization", DepartmentCode = "BCS" } },

                // BCS - 3rd Semester
                { "BCS_SEF", new SubjectInfo { Table = "bcs_3_SEF", Title = "Software Engineering Fundamentals", DepartmentCode = "BCS" } },
                { "BCS_HCI", new SubjectInfo { Table = "bcs_3_HCI", Title = "Human Computer Interaction", DepartmentCode = "BCS" } },
                { "BCS_AS", new SubjectInfo { Table = "bcs_3_AS", Title = "Applied Statistics", DepartmentCode = "BCS" } },
                { "BCS_MWSA", new SubjectInfo { Table = "bcs_3_MWSA", Title = "Microsoft Windows Server Administration", DepartmentCode = "BCS" } },
                { "BCS_CSLPA", new SubjectInfo { Table = "bcs_3_CSLPA", Title = "Cyber Security Legal Issues & Policy Analysis", DepartmentCode = "BCS" } },
                { "BCS_CCNA", new SubjectInfo { Table = "bcs_3_CCNA", Title = "Cisco Certified Network Associate", DepartmentCode = "BCS" } },

                // BBA - 1st Semester
                { "BBA_ENG_I", new SubjectInfo { Table = "bba_1_ENG_I", Title = "English I", DepartmentCode = "BBA" } },
                { "BBA_EPP", new SubjectInfo { Table = "bba_1_EPP", Title = "English for Professional Purposes", DepartmentCode = "BBA" } },
                { "BBA_POM", new SubjectInfo { Table = "bba_1_POM", Title = "Principles of Management", DepartmentCode = "BBA" } },
                { "BBA_IA", new SubjectInfo { Table = "bba_1_IA", Title = "Introduction to Accounting", DepartmentCode = "BBA" } },
                { "BBA_FCPP", new SubjectInfo { Table = "bba_1_FCPP", Title = "Fundamental Computer Principles & Programming", DepartmentCode = "BBA" } },

                // BBA - 2nd Semester
                { "BBA_HRM", new SubjectInfo { Table = "bba_2_HRM", Title = "Human Resource Management", DepartmentCode = "BBA" } },
                { "BBA_POF", new SubjectInfo { Table = "bba_2_POF", Title = "Principles of Marketing", DepartmentCode = "BBA" } },
                { "BBA_IFA", new SubjectInfo { Table = "bba_2_IFA", Title = "Internet Fundamentals & Applications", DepartmentCode = "BBA" } },
                { "BBA_E", new SubjectInfo { Table = "bba_2_E", Title = "Entrepreneurship", DepartmentCode = "BBA" } },
                { "BBA_ENG_II", new SubjectInfo { Table = "bba_2_ENG_II", Title = "English II", DepartmentCode = "BBA" } },

                // BBA - 3rd Semester
                { "BBA_S", new SubjectInfo { Table = "bba_3_S", Title = "Sociology", DepartmentCode = "BBA" } },
                { "BBA_BO", new SubjectInfo { Table = "bba_3_BO", Title = "Business Organization", DepartmentCode = "BBA" } },
                { "BBA_BL", new SubjectInfo { Table = "bba_3_BL", Title = "Business Law", DepartmentCode = "BBA" } },
                { "BBA_HRLS", new SubjectInfo { Table = "bba_3_HRLS", Title = "Human Relations and Leadership Skills", DepartmentCode = "BBA" } },
                { "BBA_M", new SubjectInfo { Table = "bba_3_M", Title = "Microeconomics", DepartmentCode = "BBA" } },
                { "BBA_PM", new SubjectInfo { Table = "bba_3_PM", Title = "Project Management", DepartmentCode = "BBA" } },

                // BHM - 1st Semester
                { "BHM_FM", new SubjectInfo { Table = "bhm_1_FM", Title = "Fundamentals of Management", DepartmentCode = "BHM" } },
                { "BHM_FBM", new SubjectInfo { Table = "bhm_1_FBM", Title = "Food and Beverage Management", DepartmentCode = "BHM" } },
                { "BHM_FOK", new SubjectInfo { Table = "bhm_1_FOK", Title = "Fundamentals of Kitchen", DepartmentCode = "BHM" } },
                { "BHM_ENG_1", new SubjectInfo { Table = "bhm_1_ENG_1", Title = "English I", DepartmentCode = "BHM" } },
                { "BHM_IHTM", new SubjectInfo { Table = "bhm_1_IHTM", Title = "Introduction to Hospitality & Tourism Management", DepartmentCode = "BHM" } },
                { "BHM_FOM", new SubjectInfo { Table = "bhm_1_FOM", Title = "Front Office Management", DepartmentCode = "BHM" } },

                // BHM - 2nd Semester
                { "BHM_HKM", new SubjectInfo { Table = "bhm_2_HKM", Title = "Housekeeping Management", DepartmentCode = "BHM" } },
                { "BHM_HA", new SubjectInfo { Table = "bhm_2_HA", Title = "Hospitality Accounting", DepartmentCode = "BHM" } },
                { "BHM_HF", new SubjectInfo { Table = "bhm_2_HF", Title = "Hotel French", DepartmentCode = "BHM" } },
                { "BHM_ENG_2", new SubjectInfo { Table = "bhm_2_ENG_2", Title = "English II", DepartmentCode = "BHM" } },
                { "BHM_HHRM", new SubjectInfo { Table = "bhm_2_HHRM", Title = "Hospitality Human Resource Management", DepartmentCode = "BHM" } },
                { "BHM_FPO", new SubjectInfo { Table = "bhm_2_FPO", Title = "Food Production Operation", DepartmentCode = "BHM" } },

                // BHM - 3rd Semester
                { "BHM_HTD", new SubjectInfo { Table = "bhm_3_HTD", Title = "Hospitality Training & Development", DepartmentCode = "BHM" } },
                { "BHM_TT", new SubjectInfo { Table = "bhm_3_TT", Title = "Travel and Tour", DepartmentCode = "BHM" } },
                { "BHM_HSM", new SubjectInfo { Table = "bhm_3_HSM", Title = "Hospitality Service Management", DepartmentCode = "BHM" } },
                { "BHM_HM", new SubjectInfo { Table = "bhm_3_HM", Title = "Hospitality Marketing", DepartmentCode = "BHM" } },
                { "BHM_HRM", new SubjectInfo { Table = "bhm_3_HRM", Title = "Hospitality Revenue Management", DepartmentCode = "BHM" } },
                { "BHM_CSIH", new SubjectInfo { Table = "bhm_3_CSIH", Title = "Customer Service in Hospitality Industry", DepartmentCode = "BHM" } },

                //MBA 1st Semester
                { "ACC", new SubjectInfo { Table = "mba_1_ACC", Title = "Business Accounting & Finance", DepartmentCode = "MBA" } },
                { "ECO", new SubjectInfo { Table = "mba_1_ECO", Title = "Business Economics", DepartmentCode = "MBA" } },
                { "HRM", new SubjectInfo { Table = "mba_1_HRM", Title = "Human Resource Management", DepartmentCode = "MBA" } },
                { "MC", new SubjectInfo { Table = "mba_1_MC", Title = "Managerial Communications", DepartmentCode = "MBA" } },
                { "BEA", new SubjectInfo { Table = "mba_1_BEA", Title = "Business Environment Analysis", DepartmentCode = "MBA" } },

                // 2nd Semester
                { "RM", new SubjectInfo { Table = "mba_2_RM", Title = "Research Methodology", DepartmentCode = "MBA" } },
                { "OM", new SubjectInfo { Table = "mba_2_OM", Title = "Operation Management", DepartmentCode = "MBA" } },
                { "MM", new SubjectInfo { Table = "mba_2_MM", Title = "Marketing Management", DepartmentCode = "MBA" } },
                { "OB", new SubjectInfo { Table = "mba_2_OB", Title = "Organizational Behavior", DepartmentCode = "MBA" } },

                // 3rd Semester
                { "SM", new SubjectInfo { Table = "mba_3_SM", Title = "Strategic Management", DepartmentCode = "MBA" } },
                { "FM", new SubjectInfo { Table = "mba_3_FM", Title = "Financial Management", DepartmentCode = "MBA" } },
                { "EM", new SubjectInfo { Table = "mba_3_EM", Title = "Entrepreneurship Management", DepartmentCode = "MBA" } },
                { "SPM", new SubjectInfo { Table = "mba_3_SPM", Title = "Sales & Promotions Management", DepartmentCode = "MBA" } },
                { "IB", new SubjectInfo { Table = "mba_3_IB", Title = "International Business", DepartmentCode = "MBA" } },
                { "HRD", new SubjectInfo { Table = "mba_3_HRD", Title = "Human Resource Development & Leadership", DepartmentCode = "MBA" } },

                // 4th Semester
                { "BI", new SubjectInfo { Table = "mba_4_BI", Title = "Banking & Insurance", DepartmentCode = "MBA" } },
                { "CRM", new SubjectInfo { Table = "mba_4_CRM", Title = "Customer Relationship Management", DepartmentCode = "MBA" } },
                { "CMN", new SubjectInfo { Table = "mba_4_CMN", Title = "Conflict Management & Negotiation Skills", DepartmentCode = "MBA" } },
                { "MOD", new SubjectInfo { Table = "mba_4_MOD", Title = "Management of Data", DepartmentCode = "MBA" } },
                { "BEG", new SubjectInfo { Table = "mba_4_BEG", Title = "Business Ethics & Governance", DepartmentCode = "MBA" } },
                { "GRP", new SubjectInfo { Table = "mba_4_GRP", Title = "Graduate Research Project Paper", DepartmentCode = "MBA" } },

                //MCS 1st semester
                { "MCS_OOP", new SubjectInfo { Table = "mcs_1_OOP", Title = "Object Oriented Programming", DepartmentCode = "MCS" } },
                { "MCS_AC", new SubjectInfo { Table = "mcs_1_AC", Title = "Algorithms And Complexity", DepartmentCode = "MCS" } },
                { "MCS_HPN", new SubjectInfo { Table = "mcs_1_HPN", Title = "High Performance Network", DepartmentCode = "MCS" } },
                { "MCS_IPWD", new SubjectInfo { Table = "mcs_1_IPWD", Title = "Internet Programming and Web Design", DepartmentCode = "MCS" } },

                // 2nd semester
                { "MCS_TS", new SubjectInfo { Table = "mcs_2_TS", Title = "Telecommunication Systems", DepartmentCode = "MCS" } },
                { "MCS_IS", new SubjectInfo { Table = "mcs_2_IS", Title = "Information Security", DepartmentCode = "MCS" } },
                { "MCS_AJ", new SubjectInfo { Table = "mcs_2_AJ", Title = "Advanced Java", DepartmentCode = "MCS" } },
                { "MCS_AI", new SubjectInfo { Table = "mcs_2_AI", Title = "Artificial Intelligence", DepartmentCode = "MCS" } },

                // 3rd semester
                { "MCS_ADB", new SubjectInfo { Table = "mcs_3_ADB", Title = "Advanced Database", DepartmentCode = "MCS" } },
                { "MCS_RM", new SubjectInfo { Table = "mcs_3_RM", Title = "Research Methodology", DepartmentCode = "MCS" } },
                { "MCS_CC", new SubjectInfo { Table = "mcs_3_CC", Title = "Cloud Computing", DepartmentCode = "MCS" } },
                { "MCS_AAIES", new SubjectInfo { Table = "mcs_3_AAIES", Title = "Advanced AI With Expert System", DepartmentCode = "MCS" } },

                // 4th semester
                { "MCS_PP", new SubjectInfo { Table = "mcs_4_PP", Title = "Project Paper", DepartmentCode = "MCS" } },
                { "MCS_SEIIT", new SubjectInfo { Table = "mcs_4_SEIIT", Title = "Seminar in Emerging Issues in IT", DepartmentCode = "MCS" } },
            };

        // NEW — derives Semester for every entry from its Table name (e.g. "bit_3_DSA" -> 3)
        // Runs once when Subjects is first accessed.
        static SubjectMap()
        {
            foreach (var kvp in Subjects)
            {
                var info = kvp.Value;
                var parts = info.Table.Split('_');
                if (parts.Length >= 2 && int.TryParse(parts[1], out int sem))
                {
                    info.Semester = sem;
                }
                else
                {
                    // Table didn't follow the "<dept>_<sem>_<code>" pattern — flag it loudly
                    // instead of silently defaulting, so a bad entry can't slip students into
                    // content they shouldn't see (or lock them out of content they should).
                    throw new InvalidOperationException(
                        $"SubjectMap: could not parse semester from Table \"{info.Table}\" for key \"{kvp.Key}\".");
                }
            }
        }
    }
}