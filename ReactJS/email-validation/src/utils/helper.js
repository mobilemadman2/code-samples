export function IsValidEmail(emailString) {
  return (/^([a-zA-Z0-9_\-.]+)@([a-zA-Z0-9_\-.]+)\.([a-zA-Z]{2,})$/.test(emailString));
}

export function GetPossibleEmails(emailString, domains) {
  const splitEmail = emailString.toLowerCase().split("@");
  let options;
  if (splitEmail.length > 1 && splitEmail[1]!=='') {
    options = domains.filter(isMatch);
    function isMatch (obj) {
      let i = 0;
      while(splitEmail[1][i]!=null && obj.name[i]!=null) {
        if(splitEmail[1][i]===obj.name[i]) i++;
        else return false;
      }
      return true;
    }
  }
  else options = domains.filter(obj => obj.popular);
  return options.map(obj => {
     return { id:obj.id, text:`${splitEmail[0]}@${obj.name}`};
  });
}

export function SetObjectClass(arr, i, className, reset) {
  if (reset) {
    arr = arr.map(obj => {
       return {id:obj.id, text:obj.text};
    });
  }
  if (i>-1) arr[i].class=className;
  return arr;
}
