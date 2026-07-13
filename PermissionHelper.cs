using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace Learning_System
{
    public static class PermissionHelper
    {
        public static bool IsLoggedIn(HttpSessionState session)
        {
            return session["ProfileId"] != null;
        }
        // True if the logged-in user is a DepartmentAdmin (full roster control) rather than
        // Staff (student-only control). Use this to conditionally render/guard the
        // "Remove Staff" actions on the shared dashboard.
        public static bool IsDepartmentAdmin(HttpSessionState session)
        {
            return GetAccessLevel(session) == "DepartmentAdmin";
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

        // Reads the department code directly from Session — login.aspx.cs already
        // resolves and stores this at login time, so no extra DB query is needed here.
        public static string GetDepartmentCode(HttpSessionState session)
        {
            return session["DepartmentCode"] as string;
        }

        public static int GetProfileId(HttpSessionState session)
        {
            return Convert.ToInt32(session["ProfileId"]);
        }

        public static bool IsAnyAdmin(string accessLevel)
        {
            return accessLevel == "MainAdmin" || accessLevel == "SuperAdmin" || accessLevel == "DepartmentAdmin";
        }

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
                    return new List<string>();
            }
        }

        public static bool CanAppointRole(string appointerAccessLevel, string roleToAppoint)
        {
            return GetAppointableRoles(appointerAccessLevel).Contains(roleToAppoint);
        }

        public static bool CanManageDepartment(HttpSessionState session, int targetDepartmentId)
        {
            string role = GetRole(session);
            string accessLevel = GetAccessLevel(session);
            int? myDepartmentId = GetDepartmentId(session);

            if (role != "Admin" && role != "Teacher")
                return false;

            if (accessLevel == "MainAdmin" || accessLevel == "SuperAdmin")
                return true;

            return myDepartmentId.HasValue && myDepartmentId.Value == targetDepartmentId;
        }

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