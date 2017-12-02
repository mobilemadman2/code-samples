<ul>
<?php
$json_link="https://api.instagram.com/v1/users/2282398417/media/recent/?access_token=2282398417.a583376.fde41043f2204d938ae5a44e52ee307a&count=4";

$json = file_get_contents($json_link);
$obj = json_decode($json, true, 512, JSON_BIGINT_AS_STRING);

foreach ($obj['data'] as $post) {

    $pic_text=$post['caption']['text'];
    $pic_link=$post['link'];
    //$pic_like_count=$post['likes']['count'];
    //$pic_comment_count=$post['comments']['count'];
    $pic_src=str_replace("http://", "https://", $post['images']['thumbnail']['url']);
    //$pic_created_time=date("F j, Y", $post['caption']['created_time']);
    //$pic_created_time=date("F j, Y", strtotime($pic_created_time . " +1 days"));

    echo "<li><a href='{$pic_link}' title='view on instagram' target='_blank'><img class='img-responsive photo-thumb' src='{$pic_src}' alt='{$pic_text}' /><i class='fa fa-instagram'></i></a></li>";
}?>
</ul>
