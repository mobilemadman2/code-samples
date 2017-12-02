import './addNewAccountModal.html';

export default class AddNewAccountModal {
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

  add() {
    // TODO
    this.mdDialog.hide('done');
  }
}
