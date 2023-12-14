# Track_your_baby_milestone
This helps to track your baby milestone.

My Baby Milestone App was designed to help mothers keep track of their baby's milestone by adding the type of the miles stone, putting a remark/description about the milestone and also selecting the date.

This first part of the App is the onboarding part that has 3 sliding pages and controlled by a Stateful widget page with smooth_page_indicator package. This section has a folder that has its own Asset manager, route manager, colors manager, dimesion manager, and string manager. Dynamic getroute was used in the route manager here. Any adjsutment in the resource folder only affects the onboarding part of the App.

The second part of the App contains the Milestone display page where there are default milestone to edit or delete. On the App there is an option to add new milestone. On the edit or add new milestone page, the save button is on the App bar.

All the logic of the app is in the milestones.dart file which is in the model folder. This was done with provider package. The provider was used to manage the State and the logic of adding ,editing and deleting milestone. The route of this is managed in the main.dart file
