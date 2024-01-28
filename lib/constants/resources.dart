import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_images.dart';

const BaseURL = "https://casmara-app-api.onrender.com/api";

String getCurrency() {
  return '₦'; // Unicode character for Naira symbol
}

String APIKEY = '4f1fe63a-5f8b-4e7f-ad38-e68445079351';
const String policy = "";


const String termsandcondions =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vitae viverra quam. Nullam tincidunt nulla libero, sed pretium nibh gravida sed. Morbi vulputate tellus nec placerat dignissim. Quisque blandit mollis nisi, ut cursus lacus tempor et. Fusce scelerisque, turpis nec suscipit egestas, libero lacus sollicitudin dolor, non eleifend est elit id massa. Quisque tempus, dui eu imperdiet finibus, libero sem cursus arcu, at imperdiet neque est eget purus. Sed vitae purus sed magna sollicitudin commodo. Morbi suscipit nulla ultrices eleifend malesuada. Nam euismod lacus eget varius tincidunt. Sed elementum diam eget convallis gravida Sed risus nisl, finibus sit amet massa et, suscipit posuere enim. Maecenas id quam sapien. Nunc commodo nibh a aliquet tempus. Vivamus lacus purus, varius id posuere vulputate, pellentesque nec quam. Aliquam dapibus egestas orci et aliquet. Suspendisse vitae gravida orci, non mollis neque. Duis sagittis, urna nec luctus mattis, metus turpis aliquet nisl, quis convallis ipsum nisi suscipit magna. Phasellus id est rutrum, lobortis turpis eu, feugiat augue. Donec ac pulvinar massa. Quisque leo dui, facilisis eget nibh ac, ultrices tempor nibh. Cras viverra est sagittis pulvinar congue. Mauris sagittis eros a nunc aliquet, finibus ullamcorper mauris porttitor. Mauris consequat porttitor urna eget sagittis. Ut quis dui id diam fermentum elementum id in nisl. Nulla convallis cursus quam, et pellentesque lorem semper id. Aenean sed sapien ultrices, facilisis turpis vitae, pulvinar elit Pellentesque eu diam congue, varius tellus hendrerit, aliquet tellus. Integer molestie tempor ex quis vehicula. In pulvinar rutrum finibus. Ut sed porta risus, non tempus dolor. Aenean vel sem mi. Integer nulla velit, sagittis a ultrices ac, pellentesque a sem. Suspendisse ipsum felis, condimentum sit amet libero nec, porttitor vestibulum tellus. Aliquam erat volutpat. Suspendisse eu accumsan lacus. Duis eu lacus sodales est sollicitudin rhoncus volutpat et sapien. Nam hendrerit, turpis posuere tristique lobortis, erat magna porttitor sem, venenatis pretium felis odio a dolor. Vivamus sed dapibus tellus. Nulla vehicula lectus non metus hendrerit euismod. Duis ornare posuere quam, in rhoncus leo auctor quis. In congue purus sit amet justo consectetur lobortis Donec nulla eros, dignissim ac finibus in, ultrices sit amet purus. Nullam rhoncus, risus et consequat sodales, mauris dolor tempus nisi, eget vehicula tortor lorem ac nisl. Aliquam eget finibus est. Suspendisse sed est pellentesque, posuere nisi nec, lobortis urna. Phasellus ornare nisl aliquam, sodales ipsum sed, interdum mauris. Sed posuere, enim accumsan sollicitudin dignissim, felis orci lobortis nulla, in tincidunt neque dolor ut enim. Phasellus varius erat at ante malesuada feugiat. Sed euismod urna sit amet lacinia bibendum.Pellentesque condimentum lectus nulla, vel egestas neque facilisis vel. Etiam id pretium mi, ac sagittis odio. Nullam eget eleifend massa, nec ultrices justo. Ut laoreet quam mi, eget faucibus quam tincidunt ac. Vestibulum id condimentum ipsum, pulvinar pellentesque orci. Maecenas dui est, posuere in tempus id, accumsan sit amet lorem. Curabitur scelerisque, nisi eu viverra dignissim, metus mi malesuada sapien, id cursus ex sapien vel orci. Vestibulum quis imperdiet risus. Nam orci nibh, dignissim quis dictum rutrum, condimentum sit amet orci. Proin aliquam tincidunt faucibus.';

const String policytext =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vitae viverra quam. Nullam tincidunt nulla libero, sed pretium nibh gravida sed. Morbi vulputate tellus nec placerat dignissim. Quisque blandit mollis nisi, ut cursus lacus tempor et. Fusce scelerisque, turpis nec suscipit egestas, libero lacus sollicitudin dolor, non eleifend est elit id massa. Quisque tempus, dui eu imperdiet finibus, libero sem cursus arcu, at imperdiet neque est eget purus. Sed vitae purus sed magna sollicitudin commodo. Morbi suscipit nulla ultrices eleifend malesuada. Nam euismod lacus eget varius tincidunt. Sed elementum diam eget convallis gravida Sed risus nisl, finibus sit amet massa et, suscipit posuere enim. Maecenas id quam sapien. Nunc commodo nibh a aliquet tempus. Vivamus lacus purus, varius id posuere vulputate, pellentesque nec quam. Aliquam dapibus egestas orci et aliquet. Suspendisse vitae gravida orci, non mollis neque. Duis sagittis, urna nec luctus mattis, metus turpis aliquet nisl, quis convallis ipsum nisi suscipit magna. Phasellus id est rutrum, lobortis turpis eu, feugiat augue. Donec ac pulvinar massa. Quisque leo dui, facilisis eget nibh ac, ultrices tempor nibh. Cras viverra est sagittis pulvinar congue. Mauris sagittis eros a nunc aliquet, finibus ullamcorper mauris porttitor. Mauris consequat porttitor urna eget sagittis. Ut quis dui id diam fermentum elementum id in nisl. Nulla convallis cursus quam, et pellentesque lorem semper id. Aenean sed sapien ultrices, facilisis turpis vitae, pulvinar elit Pellentesque eu diam congue, varius tellus hendrerit, aliquet tellus. Integer molestie tempor ex quis vehicula. In pulvinar rutrum finibus. Ut sed porta risus, non tempus dolor. Aenean vel sem mi. Integer nulla velit, sagittis a ultrices ac, pellentesque a sem. Suspendisse ipsum felis, condimentum sit amet libero nec, porttitor vestibulum tellus. Aliquam erat volutpat. Suspendisse eu accumsan lacus. Duis eu lacus sodales est sollicitudin rhoncus volutpat et sapien. Nam hendrerit, turpis posuere tristique lobortis, erat magna porttitor sem, venenatis pretium felis odio a dolor. Vivamus sed dapibus tellus. Nulla vehicula lectus non metus hendrerit euismod. Duis ornare posuere quam, in rhoncus leo auctor quis. In congue purus sit amet justo consectetur lobortis Donec nulla eros, dignissim ac finibus in, ultrices sit amet purus. Nullam rhoncus, risus et consequat sodales, mauris dolor tempus nisi, eget vehicula tortor lorem ac nisl. Aliquam eget finibus est. Suspendisse sed est pellentesque, posuere nisi nec, lobortis urna. Phasellus ornare nisl aliquam, sodales ipsum sed, interdum mauris. Sed posuere, enim accumsan sollicitudin dignissim, felis orci lobortis nulla, in tincidunt neque dolor ut enim. Phasellus varius erat at ante malesuada feugiat. Sed euismod urna sit amet lacinia bibendum.Pellentesque condimentum lectus nulla, vel egestas neque facilisis vel. Etiam id pretium mi, ac sagittis odio. Nullam eget eleifend massa, nec ultrices justo. Ut laoreet quam mi, eget faucibus quam tincidunt ac. Vestibulum id condimentum ipsum, pulvinar pellentesque orci. Maecenas dui est, posuere in tempus id, accumsan sit amet lorem. Curabitur scelerisque, nisi eu viverra dignissim, metus mi malesuada sapien, id cursus ex sapien vel orci. Vestibulum quis imperdiet risus. Nam orci nibh, dignissim quis dictum rutrum, condimentum sit amet orci. Proin aliquam tincidunt faucibus.';

var formatter = NumberFormat('#,##,000');

String customFormatCurrency(int number) {
  if (number >= 1000) {
    var formatter = NumberFormat('#,###');
    return formatter.format(number);
  } else {
    return number.toString();
  }
}


  List<Map> services = [

      {
        'icon': AppImages.electrician,
        'color': Color(0xFFFCEADA),
        'color2': Color(0xFFEF9645),
        
        'text': 'Electrician',
        'job':["Install lights","Install appliances"]
      },
      {
        'icon': AppImages.plumber,
        'color': Color(0xFFEADAFF),
        'color2': Color(0xFFEADAFF),
        'text': 'Plumber',
        'job':["Fix broken tap","Fix leaking sink"]
      },
      {
        'icon': AppImages.fumigator,
        'color': Color(0xFFFFE4E9),
       'color2': Color(0xFFFF7892),
        'text': 'Fumigator',
          'job':["Fumigate house", "Fumigate compound"]
      },
      {
        'icon': AppImages.cleaner,
        'color2': Color(0xFFEA4335),
      'color': Color(0xFFFBD9D7),
        'text': 'Cleaner',
          'job':["Clean house"]
      },
      {
        'icon': AppImages.painter,
        'color2': const Color(0xFF22DBBA),
       'color': Color(0xFFD3F8F1),
        'text': 'Painter',
        'job':['Painting']
      },
      {
        'icon': AppImages.gardener,
        'color2': Color(0xFFFF5F00),
     'color': Color(0xFFFFDFCC),
        'text': 'Gardener',
        'job':["Cut grass","Hedge Trimming"]
      },{
        'icon': AppImages.movers,
        'color2': Color(0xFF750790),
      'color': Color(0xFFE3CDE9),
        'text': 'Mover',
        'job':["Request mover"]
      },{
        'icon': AppImages.carpenter,
        'color2': Color(0xFF5DADEC),
        'color': Color(0xFFDFEFFB),
       
        'text': 'Carpenter',
        'job':['Carpentry works']
      },
    ];
   

     List<Map<String, dynamic>> priority = [
    {
      "type": "High Priority",
      'color': Color(0xFFEB5757),
      'color2': Color(0xFFFCE6E6)
    },
    {
      "type": "Medium Priority",
      'color': Color(0xFFF2994A),
      'color2': Color.fromARGB(255, 255, 242, 231),
    },
    {
      "type": "Low Priority",
      'color': Color(0xFFF2C94C),
      'color2': Color.fromARGB(255, 255, 247, 222),
    },
    {
      "type": "None",
      'color': Color(0xFF2D9CDB),
      'color2': Color.fromARGB(255, 228, 245, 255),
    },
  ];