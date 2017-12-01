import './inviteToNewActivityModal.html';

export default class InviteToNewActivityModal {
  constructor($mdDialog, $scope) {
    'ngInject';


    /*
     * Bind services
     */
    this.scope = $scope;
    this.mdDialog = $mdDialog;
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
