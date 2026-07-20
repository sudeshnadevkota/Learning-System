using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Common
{
    // Any dynamically-loaded section control (StaffManageControl, StudentManageControl,
    // SubjectManageControl, etc.) implements this so LoadSection() knows to trigger its
    // initial data load right after adding it to the tree. IsPostBack can't be trusted
    // for this — the sidebar click itself is a postback, so a control that just got
    // created still sees IsPostBack == true.
    public interface IDynamicSection
    {
        void LoadInitialData();
    }

    public abstract class BaseAdminMaster : MasterPage
    {
        protected abstract PlaceHolder DynamicPlaceHolder { get; }

        public string ActivePage { get; set; } = "";

        private string SessionKey => "ActiveSection_" + GetType().Name;

        // Lets concrete masters check for saved state without duplicating
        // the SessionKey string themselves.
        protected bool HasActiveSection => Session[SessionKey] != null;

        private const string DynamicControlId = "dynamicSection";

        protected void LoadSection(string sectionKey, string controlVirtualPath)
        {
            Session[SessionKey] = Tuple.Create(sectionKey, controlVirtualPath);
            DynamicPlaceHolder.Controls.Clear();
            var ctrl = LoadControl(controlVirtualPath);
            ctrl.ID = DynamicControlId;
            DynamicPlaceHolder.Controls.Add(ctrl);
            ActivePage = sectionKey;

            // Fresh load (user just clicked the nav link) — tell the control to
            // fetch its data now, since its own Page_Load can't tell the difference
            // between "I'm new" and "this request happens to be a postback."
            if (ctrl is IDynamicSection section)
                section.LoadInitialData();
        }

        // Call from Page_Load on every postback so the dynamically loaded
        // control gets re-added to the tree before ViewState is processed.
        protected bool RestoreSection()
        {
            if (Session[SessionKey] is Tuple<string, string> saved)
            {
                DynamicPlaceHolder.Controls.Clear();
                var ctrl = LoadControl(saved.Item2);
                ctrl.ID = DynamicControlId; // must match the ID used when first loaded
                DynamicPlaceHolder.Controls.Add(ctrl);
                ActivePage = saved.Item1;

                // Deliberately NOT calling LoadInitialData() here — this is a plain
                // postback of an already-loaded section (e.g. GridView paging), so
                // the control's state should come back via ViewState, not a re-fetch.
                return true;
            }
            return false;
        }

        protected string GetNavClass(string key)
        {
            return key == ActivePage ? "c-nav-link active" : "c-nav-link";
        }
    }
}