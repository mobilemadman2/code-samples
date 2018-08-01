const NUMBER_OF_LEAVES = 13;
const NUMBER_OF_LOGOS = 2;

function init() {
    var container = document.getElementById('leafContainer');
    var leafSvg = document.getElementById('leafSvg').innerHTML;
    var hearts = document.getElementsByClassName('heart');
    var logos = document.getElementsByClassName('logo');
    var feathers = document.getElementsByClassName('feather');

    var containerHeight = container.offsetHeight * 0.7;
    var maxWidth = containerHeight * 0.115;
    var treeWidth1 = containerHeight * 0.5;
    var treeWidth2 = containerHeight * 0.4;

    document.getElementById('turkeyContainer').className = 'explode';

    feathers[0].addEventListener(
      'webkitTransitionEnd',
      function( event ) {
        if (event.propertyName === 'transform') fallingFeathers(feathers, logos, hearts);
      }
    );

    container.appendChild(createALeaf(leafSvg, maxWidth, 'l1', treeWidth2));
    container.appendChild(createALeaf(leafSvg, maxWidth, 'l2', treeWidth2));
    container.appendChild(createALeaf(leafSvg, maxWidth, 'l3', treeWidth2));
    container.appendChild(createALeaf(leafSvg, maxWidth, 'l4', treeWidth1));
    container.appendChild(createALeaf(leafSvg, maxWidth, 'l5', treeWidth1));

    for (var i = 0; i < NUMBER_OF_LEAVES; i++) {
      container.appendChild(createALeaf(leafSvg, maxWidth));
    }

    leafSvg = document.getElementById('logoSvg').innerHTML;
    for (var i = 0; i < NUMBER_OF_LOGOS; i++) {
      container.appendChild(createALeaf(leafSvg, maxWidth));
    }
}


/*
    Receives the lowest and highest values of a range and
    returns a random integer that falls within that range.
*/
function randomInteger(low, high)
{
    return low + Math.floor(Math.random() * (high - low));
}


/*
   Receives the lowest and highest values of a range and
   returns a random float that falls within that range.
*/
function randomFloat(low, high)
{
    return low + Math.random() * (high - low);
}


/*
    Receives a number and returns its CSS pixel value.
*/
function percentValue(value)
{
    return value + '%';
}
/*
    Receives a number and returns its CSS pixel value.
*/
function pixelValue(value)
{
    return value + 'px';
}


/*
    Returns a duration value for the falling animation.
*/

function durationValue(value)
{
    return value + 's';
}


function fallingFeathers(feathers, logos, hearts) {
  feathers[0].style.webkitAnimationName = 'feather-1-spin';
  feathers[0].style.webkitAnimationDuration = '4s';

  feathers[1].style.webkitAnimationName = 'feather-2-spin';
  feathers[1].style.webkitAnimationDuration = '5s';

  feathers[2].style.webkitAnimationName = 'feather-3-spin';
  feathers[2].style.webkitAnimationDuration = '3s';

  feathers[3].style.webkitAnimationName = 'feather-2-spin';
  feathers[3].style.webkitAnimationDuration = '4s';

  feathers[4].style.webkitAnimationName = 'feather-3-spin';
  feathers[4].style.webkitAnimationDuration = '5s';

  feathers[5].style.webkitAnimationName = 'feather-1-spin';
  feathers[5].style.webkitAnimationDuration = '3s';

  feathers[6].style.webkitAnimationName = 'feather-2-spin';
  feathers[6].style.webkitAnimationDuration = '3s';

  feathers[7].style.webkitAnimationName = 'feather-3-spin';
  feathers[7].style.webkitAnimationDuration = '4s';

  feathers[8].style.webkitAnimationName = 'feather-1-spin';
  feathers[8].style.webkitAnimationDuration = '5s';

  feathers[9].style.webkitAnimationName = 'feather-1-spin';
  feathers[9].style.webkitAnimationDuration = '3s';

  feathers[10].style.webkitAnimationName = 'feather-3-spin';
  feathers[10].style.webkitAnimationDuration = '1s';

  feathers[11].style.webkitAnimationName = 'feather-1-spin';
  feathers[11].style.webkitAnimationDuration = '3s';

  feathers[12].style.webkitAnimationName = 'feather-3-spin';
  feathers[12].style.webkitAnimationDuration = '2s';

  logos[0].style.webkitAnimationName = 'logo-1-spin';
  logos[0].style.webkitAnimationDuration = '2s';

  logos[1].style.webkitAnimationName = 'logo-2-spin';
  logos[1].style.webkitAnimationDuration = '2s';

  logos[2].style.webkitAnimationName = 'logo-3-spin';
  logos[2].style.webkitAnimationDuration = '2s';

  hearts[0].style.webkitAnimationName = 'feather-1-spin';
  hearts[0].style.webkitAnimationDuration = '3s';

  hearts[1].style.webkitAnimationName = 'feather-2-spin';
  hearts[1].style.webkitAnimationDuration = '3s';

  hearts[2].style.webkitAnimationName = 'feather-3-spin';
  hearts[2].style.webkitAnimationDuration = '3s';

  document.getElementById('feathers').className = 'drop';
  document.getElementById('logos').className = 'drop';
  document.getElementById('hearts').className = 'drop';
}

function createALeaf(leafSvg, maxWidth, id, hor) {
    var leafDiv = document.createElement('span');
    var leafInner = document.createElement('span');

    leafDiv.style.zIndex = randomInteger(200,900);

    leafDiv.style.width = pixelValue(randomInteger(20, 120) * maxWidth / 100);

    var spinAnimationName;
    var leafDelay = durationValue(randomFloat(1, 3));

    switch(id) {
      case 'l1':
        leafDiv.style.webkitAnimationName = 'drop-1, fade';
        leafDiv.style.right = pixelValue(hor * 0.6);
        leafDiv.style.top = percentValue(5);
        leafDiv.addEventListener('webkitAnimationEnd',function( event ) { leafDiv.style.display = 'none'; }, false);
        spinAnimationName = 'clockwiseSpin';
      break;
      case 'l2':
        leafDiv.style.webkitAnimationName = 'drop-2, fade';
        leafDiv.style.right = pixelValue(hor * 0.1);
        leafDiv.style.top = percentValue(30);
        spinAnimationName = 'clockwiseSpinAndFlip';
        leafDiv.addEventListener('webkitAnimationEnd',function( event ) { leafDiv.style.display = 'none'; }, false);
      break;
      case 'l3':
        leafDiv.style.webkitAnimationName = 'drop-3, fade';
        leafDiv.style.right = pixelValue(hor * 0.9);
        leafDiv.style.top = percentValue(12);
        spinAnimationName = 'clockwiseSpin';
        leafDiv.addEventListener('webkitAnimationEnd',function( event ) { leafDiv.style.display = 'none'; }, false);
      break;
      case 'l4':
        leafDiv.style.webkitAnimationName = 'drop-4, fade';
        leafDiv.style.left = pixelValue(hor * 0.1);
        leafDiv.style.top = percentValue(30);
        spinAnimationName = 'clockwiseSpin';
        leafDiv.addEventListener('webkitAnimationEnd',function( event ) { leafDiv.style.display = 'none'; }, false);
      break;
      case 'l5':
        leafDiv.style.webkitAnimationName = 'drop-5, fade';
        leafDiv.style.left = pixelValue(hor * 0.8);
        leafDiv.style.top = percentValue(10);
        spinAnimationName = 'clockwiseSpinAndFlip';
        leafDiv.addEventListener('webkitAnimationEnd',function( event ) { leafDiv.style.display = 'none'; }, false);
      break;
      default:
        leafDiv.style.left = percentValue(randomInteger(0, 100));
        leafDiv.style.top = percentValue(-10);
        leafDiv.style.webkitAnimationName = 'drop, fade';
        leafDelay = durationValue(randomFloat(3, 9));
        spinAnimationName = (Math.random() < 0.5) ? 'clockwiseSpin' : 'counterclockwiseSpinAndFlip';
      break;
    }

    leafDiv.style.webkitAnimationDelay = leafDelay + ', ' + leafDelay;
    leafInner.style.webkitAnimationName = spinAnimationName;

    var fadeAndDropDuration = durationValue(randomFloat(5, 11));

    var spinDuration = durationValue(randomFloat(4, 8));
    leafDiv.style.webkitAnimationDuration = fadeAndDropDuration + ', ' + fadeAndDropDuration;
    leafInner.style.webkitAnimationDuration = spinDuration;

    leafInner.className = 'image';

    leafInner.innerHTML += leafSvg;

    if(id) leafDiv.id = id;

    leafDiv.appendChild(leafInner);

    return leafDiv;
}

window.addEventListener('load', init, false);
