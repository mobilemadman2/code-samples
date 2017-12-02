import './inviteToOldActivityModal.html';

export default class InviteToOldActivityModal {
  constructor($mdDialog, $scope, activities) {
    'ngInject';

    /*
     * Bind services
     */
    this.scope = $scope;
    this.mdDialog = $mdDialog;


    /*
     * Synchronous data
     */
    this.activities = activities;
  }


  /*
   * Actions
   */
  cancel() {
    this.mdDialog.cancel();
  }

  invite() {
    // TODO
  }
}
