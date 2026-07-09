using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace Learning_System
{
    /// <summary>
    /// Central helper for checking what a logged-in user is allowed to do,
    /// based on the combination of Role + AccessLevel + DepartmentId.
    /// Session is assumed to hold (set these at login, adjust names to match your Login.aspx.cs):
    ///   Session["ProfileId"]     -> int, the logged-in user's UserProfile.ProfileId
    ///   Session["Role"]          -> "Student" / "Teacher" / "Admin"
    ///   Session["AccessLevel"]   -> "MainAdmin" / "SuperAdmin" / "DepartmentAdmin" (Admins only, else null)
    ///   Session["DepartmentId"]  -> int? (Staff and DepartmentAdmin are scoped to one department)
    /// </summary>
    public static class PermissionHelper
    {
        public static bool IsLoggedIn(HttpSessionState session)
        {
            return session["ProfileId"] != null;
        }

        public static string GetRole(HttpSessionState session)
        {
            return session["Role"] as string;
        }

        public static string GetAccessLevel(HttpSessionState session)
        {
            return session["AccessLevel"] as string;
        }

        public static int? GetDepartmentId(HttpSessionState session)
        {
            return session["DepartmentId"] as int?;
        }

        public static int GetProfileId(HttpSessionState session)
        {
            return Convert.ToInt32(session["ProfileId"]);
        }

        /// <summary>
        /// Returns true if the given AccessLevel is one of the three admin tiers at all.
        /// </summary>
        public static bool IsAnyAdmin(string accessLevel)
        {
            return accessLevel == "MainAdmin" || accessLevel == "SuperAdmin" || accessLevel == "DepartmentAdmin";
        }

        /// <summary>
        /// Which roles can the given AccessLevel appoint?
        /// MainAdmin       -> SuperAdmin, DepartmentAdmin, Staff
        /// SuperAdmin      -> DepartmentAdmin, Staff
        /// DepartmentAdmin -> Staff only
        /// </summary>
        public static List<string> GetAppointableRoles(string accessLevel)
        {
            switch (accessLevel)
            {
                case "MainAdmin":
                    return new List<string> { "SuperAdmin", "DepartmentAdmin", "Staff" };
                case "SuperAdmin":
                    return new List<string> { "DepartmentAdmin", "Staff" };
                case "DepartmentAdmin":
                    return new List<string> { "Staff" };
                default:
                    return new List<string>(); // Staff/Student can appoint no one
            }
        }

        public static bool CanAppointRole(string appointerAccessLevel, string roleToAppoint)
        {
            return GetAppointableRoles(appointerAccessLevel).Contains(roleToAppoint);
        }

        /// <summary>
        /// Central "can this user manage resource X for department Y" check —
        /// e.g. NoticeManage.aspx asks CanManageDepartment(session, targetDepartmentId).
        /// </summary>
        public static bool CanManageDepartment(HttpSessionState session, int targetDepartmentId)
        {
            string role = GetRole(session);
            string accessLevel = GetAccessLevel(session);
            int? myDepartmentId = GetDepartmentId(session);

            if (role != "Admin" && role != "Teacher")
                return false; // Students never manage department resources

            if (accessLevel == "MainAdmin" || accessLevel == "SuperAdmin")
                return true; // college-wide access

            // DepartmentAdmin or Staff — only their own department
            return myDepartmentId.HasValue && myDepartmentId.Value == targetDepartmentId;
        }

        /// <summary>
        /// Call at the top of Page_Load on any admin-only page.
        /// Redirects away if the logged-in user's AccessLevel isn't in the allowed list.
        /// </summary>
        public static void RequireAccessLevel(System.Web.UI.Page page, params string[] allowedAccessLevels)
        {
            var session = page.Session;

            if (!IsLoggedIn(session) || GetRole(session) != "Admin")
            {
                page.Response.Redirect("~/AccessDenied.aspx");
                return;
            }

            string accessLevel = GetAccessLevel(session);
            bool allowed = false;
            foreach (var level in allowedAccessLevels)
            {
                if (level == accessLevel) { allowed = true; break; }
            }

            if (!allowed)
            {
                page.Response.Redirect("~/AccessDenied.aspx");
            }
        }
    }
}