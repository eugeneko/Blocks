
void Start()
{
    // Register a menu item to open the Bulk Rename window
    Plugin::RegisterMenuItem("Bulk Rename", "Action_BulkRename");
    SubscribeToEvent("Action_BulkRename", "Action_BulkRename");
    
    Plugin::RegisterPropertyPage("NavigationMesh", "void Page_NavButtons(NavigationMesh@)", true);
    Plugin::RegisterPropertyPage("DynamicNavigationMesh", "void Page_NavButtons(NavigationMesh@)", true);
}

void Action_BulkRename(StringHash eventType, VariantMap& eventData)
{
    Editor::ShowToolWindow("Bulk Rename", "void BulkRenameWindow()");
}

String renamingName = "";
void BulkRenameWindow()
{
    if (Editor::GetSelectionCount() > 0)
    {
        ImGui::Text("Rename To:");
        ImGui::InputText("##renaming_field", renamingName);
        ImGui::Separator();
        if (ImGui::Button("Apply Renaming"))
        {
            int selCt = Editor::GetSelectionCount();
            for (int i = 0; i < selCt; ++i)
            {
                Node@ node = cast<Node>(Editor::GetSelected(i));
                if (node != null)
                    node.name = renamingName;
            }
        }        
    }
    else
    {
        ImGui::Text("^1< nothing selected to rename >");
    }
}

void Page_NavButtons(NavigationMesh@ mesh)
{
    ImGui::Separator();
    ImGuiUX::PushLargeBoldFont();
    if (ImGui::Button("Rebuild NavMesh"))
        mesh.Build();
    ImGuiUX::PopFont();
}