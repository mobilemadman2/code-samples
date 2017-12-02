import moment from 'moment';
import angular from 'angular';
import uiRouter from 'angular-ui-router';
import ngMessages from 'angular-messages';
import angularMeteor from 'angular-meteor';

import { name as Messages } from '../../config/messages.js';
import { compareTo as Compare } from '../../directives/compare.js';
import AddNewAccountModal from '../addNewAccountModal/addNewAccountModal';

import './account.html';

const name = 'account';

const config = ($stateProvider) => {
  'ngInject';

  $stateProvider.state('portal.account', {
    url: '/account',
    template: '<account></account>',
  });
};

class Account {
  constructor($scope, $window, $mdDialog, $mdToast, messages) {
    'ngInject';


    /*
     * Bind services
     */
    this.scope = $scope;
    this.mdToast = $mdToast;
    this.messages = messages;
    this.mdDialog = $mdDialog;


    /*
     * Synchronous data
     */
    this.newPass = '';
    this.newEmail = '';
    this.confirmPass = '';
    this.currentPass = '';


    /*
     * Asynchronous data
     */
    this.user = {};
    this.users = [];
    this.school = {};


    /*
     * Lookups
     */
    this.frequencies = [];


    /*
     * UI states
     */
    this.searchText = '';
    this.showSearch = false;
    this.showEmailTab = false;
    this.showPasswordTab = false;


    /*
     * Activate
     */
    this.getUser();
    this.getUsers();
    this.getSchool();
    this.getFrequencies();
  }


  /*
   * UI methods
   */
  closePasswordTab() {
    this.newPass = '';
    this.currentPass = '';
    this.confirmPass = '';
    this.showPasswordTab = false;
  }

  closeEmailTab() {
    this.newEmail = '';
    this.currentPass = '';
    this.showEmailTab = false;
  }

  getDateString(date) {
    if (date) {
      return moment(date).format('dddd, MMMM Do YYYY');
    }

    return 'N/A';
  }

  getPasswordStrength() {
    let conditionsMet = 0;

    if (typeof this.newPass === 'string') {
      if (this.newPass.length > 9) {
        conditionsMet += 1;

        const specialA = /\^|\*|\(|\)|\[|\]|\.|\$|\?/;
        const specialB = /`|>|,|~|!|@|#|£|%|\|'|<|&|=|{|}|\|+/;

        if (/\d/.test(this.newPass)) {
          conditionsMet += 1;
        }

        if (/[a-z]/.test(this.newPass) && /[A-Z]/.test(this.newPass)) {
          conditionsMet += 1;
        }

        if (specialA.test(this.newPass) || specialB.test(this.newPass)) {
          conditionsMet += 1;
        }
      }
    }

    return `${conditionsMet * 25}%`;
  }

  getRemaining() {
    const diff = moment(this.school.Membership_end__c).diff(moment());
    const dur = moment.duration(diff);

    let remaining = '';

    if (dur.years() > 0) {
      remaining += `${dur.years()} years, `;
    }

    if (dur.months() > 0) {
      remaining += `${dur.months()} months and `;
    }

    if (dur.days() > 0) {
      remaining += `${dur.days()} days`;
    }

    return remaining;
  }

  getDaysRemaining() {
    return moment(this.school.Membership_end__c).diff(moment(), 'days');
  }

  getNextEmailDate() {
    let output = null;

    if (this.user && this.user.profile) {
      let lastDate = this.user.profile.Last_notification_date__c;
      const frequency = this.user.profile.Notification_frequency__c;

      if (!lastDate) {
        lastDate = moment();
      }

      if (frequency === 'Daily') {
        output = moment(lastDate).add(1, 'day');
      } else if (frequency === 'Weekly') {
        output = moment(lastDate).add(1, 'week');
      } else if (frequency === 'Fortnightly') {
        output = moment(lastDate).add(14, 'days');
      } else if (frequency === 'Monthly') {
        output = moment(lastDate).add(1, 'month');
      }

      if (frequency !== 'Never' && output.isBefore(moment())) {
        output = moment();
      }
    }

    return this.getDateString(output);
  }


  /*
   * Actions
   */
  addAccount() {
    this.mdDialog.show({
      controller: AddNewAccountModal,
      controllerAs: 'addNewAccountModal',
      parent: angular.element(document.body),
      templateUrl: 'imports/ui/components/addNewAccountModal/addNewAccountModal.html',
    });
  }

  enableUser(userId) {
    this.users = this.users.map((row) => {
      const output = row;

      if (userId === row.Id) {
        output.Enabled__c = true;
      }

      return output;
    });
  }

  disableUser(userId) {
    this.users = this.users.map((row) => {
      const output = row;

      if (userId === row.Id) {
        output.Enabled__c = false;
      }

      return output;
    });
  }

  changeFrequency() {
    const frequency = this.user.profile.Notification_frequency__c;

    Meteor.call('updateEmailFrequency', frequency, (err) => {
      if (err) {
        this.showToast(this.messages.generic, 'error');
      } else {
        this.showToast(this.messages.generic_save, 'generic');
      }
    });
  }

  changeEmail() {
    Meteor.call('updateUserEmail', this.currentPass, this.newEmail, (err) => {
      if (err) {
        this.showToast(this.messages.generic, 'error');
      } else {
        this.showToast(this.messages.email_changed, 'success');
        this.closeEmailTab();
      }
    });
  }

  changePassword() {
    Meteor.call('updateUserPassword', this.currentPass, this.newPass, (err) => {
      if (err) {
        this.showToast(this.messages.generic, 'error');
      } else {
        this.showToast(this.messages.password_changed, 'success');
        this.closePasswordTab();
      }
    });
  }


  /*
   * Helpers
   */
  showToast(message, style) {
    const toastr = this
      .mdToast
      .simple()
      // .toastClass(style)
      .textContent(message)
      .position('top right')
      .parent(angular.element('.ff-toast-parent'));

    this.mdToast.show(toastr);
  }

  getFrequencies() {
    Meteor.call('getNotificationFrequencyLookup', (err, res) => {
      this.frequencies = res;
      this.scope.$apply();
    });
  }

  getUser() {
    Meteor.call('getUser', (err, res) => {
      this.user = res;
      this.scope.$apply();
    });
  }

  getUsers() {
    Meteor.call('getUsers', (err, res) => {
      this.users = res;
      this.scope.$apply();
    });
  }

  getSchool() {
    Meteor.call('getSchool', (err, res) => {
      this.school = res;
      this.scope.$apply();
    });
  }
}

export default angular
  .module(name, [
    uiRouter,
    ngMessages,
    angularMeteor,

    Messages,
  ])
  .component(name, {
    controllerAs: name,
    controller: Account,
    templateUrl: `imports/ui/components/${name}/${name}.html`,
  })
  .config(config)
  .directive('compare', Compare);
