//
//Скрипт управления картой
//
var time;
var pos = 0;

function animation_city(num)
{
  document.getElementById("city_" + num).style.display = "inline";
  
  time = setInterval("animate_map(" + num + ")", 130);
  
  pos = 0;
}

function animation_city_stop(num)
{
  time = clearInterval(time);
  
  document.getElementById("city_" + num).style.backgroundPosition = "0px 0px";
  
  document.getElementById("city_" + num).style.display = "none";
}

function animate_map(num)
{
  if ( pos != 100 )
  {
    pos = pos + 25;
    document.getElementById("city_" + num).style.backgroundPosition = "-" + pos + "px 0px";
  }
  else
  {
    pos = 0;
    
    document.getElementById("city_" + num).style.backgroundPosition = "-" + pos + "px 0px";
  }
}

function view_map_center(num)
{
  document.getElementById("city_data").innerHTML = document.getElementById("city_center_data_" + num).innerHTML;  
}

function view_map(num, flag_content)
{
  document.getElementById("map_" + num).style.display = "inline";
  
  if (typeof(flag_content) != "boolean")
  {
    flag_content = true;
  }
  
  if (flag_content)
  {
    document.getElementById("city_data").innerHTML = document.getElementById("city_data_" + num).innerHTML;
  }
}

function hide_map(num, flag_content)
{
  document.getElementById("map_" + num).style.display = "none";
  
  if (typeof(flag_content) != "boolean")
  {
    flag_content = true;
  }
  
  if (flag_content)
  {
    document.getElementById("city_data").innerHTML = document.getElementById("oblast").innerHTML;
  }
}