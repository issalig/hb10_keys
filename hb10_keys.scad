/*
 Decription: Keycaps for HB-10, HB-20, and probably some others
 Author: Ismael Salvador
 Date: 04/09/22
*/

module cursor_key(){
    thick=1;
    rounded=0.6;
    
    difference(){
        //outer shell
    intersection()
    {
    //xy profile
    linear_extrude(height=9.6, twist=0)        
        polygon(points=[[0,0],[36,36], [36,0]]);
       
    //xz profile    
    translate([0,0,0])
    rotate([0,-90, 45])
    translate([0,-26.5,-49.7])      
    #linear_extrude(height=49.7, twist=0)
        polygon(points=[[0,0],[0,26.5],[9.6,24.5], [8,11.5], [5, 9.5], [1,2] ]);       
    }
    
    //inner shell
    translate([2.5,1,0])
    scale(0.90)
    intersection()
    {
    //reduced triangle
    linear_extrude(height=9.6, twist=0)
        polygon(points=[[0,0],[36,36], [36,0]]);      
    
    translate([0,0,0])
    rotate([0,-90,45])
    translate([0,-26.5,-49.7])
    linear_extrude(height=49.7, twist=0)
        polygon(points=[[0,0],[0,26.5],[9.6,24.5], [8,11.5], [5, 9.5], [1,2] ]);
    }
}
    //central pin
    rotate([0,0,45])
    translate([0+1,-9-9.7+0.6,0])
    {
    translate([49.7/2,9,0]){
        rotate([0,0,45])
    cylinder(h=8, $fn=4,r=1.5*1.41-0.1);
        translate([0,0,1])
        rotate([0,0,45])
    cylinder(h=1.5, $fn=4,r=1.5*1.41+0.1);
    }
    
    //retainer
    difference(){
    translate([49.7/2-11.5+0.5,9,2])
    cube([5,2.2,11.5+1.5],center=true);
        
    translate([49.7/2-11.5+0.5,9,0]){
        translate([0,0,-2.5])
        rotate([90,0,0])
        cube([2,1.5,5], center=true);        
    }
    }
    //retainer
    difference(){
    translate([49.7/2+11.5-0.5,9,2]){
        cube([5,2.2,11.5+1.5], center=true);
    }
    translate([49.7/2+11.5-0.5,9,0]){
        translate([0,0,-2.5])
        rotate([90,0,0])
        cube([2,1.5,5], center=true);
        
    }
    }
    }
}

module key(width=18.2, height=18.2, side_diff=6.3, retainer=false, row=1){

    hook_in_one_piece=0;
    rounded_corner=2;
    thickness=1;            
    upper_bevel_radius=0.3;
    y_off =2;  //upper y offset
    
    //row 0 is the same as row 1
    //           0     1     2     3     4     5
    h_front =[10.5, 10.5,  9.2,  9.2, 10.2,  8.9];  //front height
    h_back  =[10.5, 10.5,  8.1,  7.3,  7.3,  8.9];  //bottom height
    w_up    =13.1;                                  //upper width
    
    //compute angle for upper side
    ang=atan2(h_front[row]-h_back[row], w_up);
      
    //keycap is the difference of inner and outer shell
    //inner and outher shells are hulls from upper and bottom countours
    difference()
    {
    //outer
    hull()
    {        
        //bottom side
        minkowski(){
        cube([width-2*rounded_corner, height-2*rounded_corner, 0.01], center=true);
            cylinder(r=rounded_corner,h=0.01, $fn=40);
        }
                
        //upper side        
        translate([0, y_off, min(h_front[row],h_back[row])+abs(h_front[row]-h_back[row])/2])        
        //echo(ang);
        rotate([-ang,0,0])
            minkowski()
        {
            minkowski()
        {
        cube([width-side_diff-2*rounded_corner, 14-2*rounded_corner, 0.01], center=true);        
                cylinder(r=rounded_corner,h=0.01, $fn=40);
            
        }
            sphere(r=upper_bevel_radius, $fn=40);
    }
        
    }
    
    //inner
        hull()
    {
        
        //bottom
        minkowski(){                
        cube([width-2*thickness-rounded_corner, height-2*thickness-rounded_corner, 0.01], center=true);
                    cylinder(r=rounded_corner/2,h=0.01, $fn=40);
        }
        
        //upper
        translate([0,2*thickness,min(h_front[row],h_back[row])-2*thickness]) 
        rotate([-ang,0,0])

        minkowski(){ 
        cube([width-6.3-2*thickness-rounded_corner, 14-2*thickness-rounded_corner, 0.01], center=true);
                   cylinder(r=rounded_corner/2,h=0.01, $fn=40);
        }
    }
}
    
    //key pin
    translate([0,0,1.5+1])
    #cube([3,3,3],center=true);       //pin squared body
    translate([0,0,1.5+1])
    #cube([3.2,3.2,0.5],center=true); //a little wider section

    cyl_offset = 4;
    cyl_h=min(h_front[row],h_back[row])-cyl_offset;    
    translate([0,0,cyl_offset])
    #cylinder(r=1.41*1.5,h=cyl_h, $fn=60);//cylindrical part

    base_offset = 5.6;
    base_h=min(h_front[row],h_back[row])-base_offset;
    translate([0,0,base_offset])              
    #cylinder(r=3.5,h=base_h, $fn=60);       //reinforcement base

    //longer keys have retainers
    if (retainer){
            retainer_offset = 2.7;
            retainer_h=min(h_front[row],h_back[row])-retainer_offset;            
         
            difference(){            
            //outer
            translate([-20.5/2,-1.5, retainer_h/2+2.7])
            cube([2.9,4.4,retainer_h], center=true);                             
                
            //hole    
            translate([-20.5/2,-1.5, 8.1/2])                
            cube([2,3.4,(8.1)], center=true); 
            }  
            
            difference(){            
            //outer
            translate([20.5/2,-1.5, retainer_h/2+2.7])
            cube([2.9,4.4,retainer_h], center=true);                             
                
            //hole    
            translate([20.5/2,-1.5, 8.1/2])                
            cube([2,3.4,(8.1)], center=true); 
            }        
    }
}

module retainer_hinge(){
        difference(){
        //main body
        translate([0,0,2.6/2])
        cube([1.8,8.2,2.6], center=true);
        
        //hole for metal clip
        translate([0,0,2.6/2])
        #cube([1.8*3,7,1.15], center=true); 
        }
        
        //leg
        translate([0,0.4,2.6+2.5/2])
        #cube([1.8,3.2-0.1,2.5], center=true); 
        
        //give a little bit of traction
        translate([0,0.4,2.6+2.5/2])
        #cube([1.8,3.2,0.5], center=true); 
        
    }
    
module function_key(){
    rounded=0.5;
    top_x=25.9-0.2;
    top_y=6-0.2;
    bottom_x=25.9-0.2;
    bottom_y=7-0.2;
    thick=2;
    
    difference()
    {
    //outer
    hull()
    {
        //bottom
        #minkowski(){
    cube([bottom_x-2*rounded,bottom_y-2*rounded, 0.01], center=true);
        cylinder(r=rounded, h=0.01, $fn=40);
        }
        //top        
    translate([0,0,10.9-rounded/3-0.1/2])
        minkowski(){
        minkowski(){
    cube([top_x-2*rounded-2/3*rounded,top_y-2*rounded-2/3*rounded,0.1], center=true);
            cylinder(r=rounded, h=0.01, $fn=40);
        }
        sphere(r=rounded/3,$fn=40);
    }
    }
    
    //inner
    hull()
    {
        //bottom
    cube([bottom_x-thick,bottom_y-thick,0.1], center=true);
        //top
    translate([0,0,10.9-1])        
    cube([top_x-thick,top_y-thick,0.1], center=true);
    }
}
    //circular pin
    translate([25.9/2-4.2,0,3.2])
    cylinder(r=2,h=10.9-3.2, $fn=50); //reinforce base

    translate([25.9/2-4.2,0,0+1])
    cylinder(r=1,h=10.9-1, $fn=50);
    translate([25.9/2-4.2,0,0])    
    cylinder(r2=1,r1=0.5, h=1, $fn=50); //thinner ending

    //circular pin
    translate([-(25.9/2-4.2),0,3.2])
    cylinder(r=2,h=10.9-3.2, $fn=50); //reinforce base

    translate([-(25.9/2-4.2),0,0+1])
    cylinder(r=1,h=10.9-1, $fn=50);
    translate([-(25.9/2-4.2),0,0])    
    cylinder(r2=1,r1=0.5, h=1, $fn=50); //thinner ending

    //central guide
difference()
{
    union()
    {      
    //middle  
    translate([0,0,(10.9-3.2)/2+3.2])
    cube([1,5.6,10.9-3.2], center=true);
        
    translate([2.5,0,(10.9-3.2)/2+3.2])
    cube([1,5.6,10.9-3.2], center=true);
        
    translate([-2.5,0,(10.9-3.2)/2+3.2])
    cube([1,5.6,10.9-3.2], center=true);

    //edges
    translate([5,0,(10.9-3.2)/2+3.2])
    cube([1,5.6,10.9-3.2], center=true);
    translate([-5,0,(10.9-3.2)/2+3.2])
    cube([1,5.6,10.9-3.2], center=true);        
        
    }
    //central hole
    translate([0,0,(10.9-3.2)/2+3.2])
    cube([9.5,1.2,10.9-3.2], center=true);
}
}

module key_stem(height=8.4, diam=5.6, thick=0.7, sq_height=1.7, sq_side=3.2, function_stem=0){
    //diam=5.8, sq_side=3  alternative values, it depends on the printer tolerance
    difference(){ 
    union(){
    //bottom ring
    difference(){
        cylinder(d=8.2,h=2.3, $fn=80);
        cylinder(d=8.2-0.8*2,h=2.3, $fn=80);        
    }
    
    //internal bottom
    translate([0,0,1])
    difference(){
        cylinder(d=8.2,h=1.3, $fn=0);
        //cylinder(d=8.2-0.8*2,height=1.3, $fn=4);
        translate([0,0,2.3/2])
        #cube([4.9,3.4,2.3], center=true);
    }
    
    

    }
    
    //clamp holes
    translate([8.2/2,0,1/2+0.5])
    #cube([8.2,2.3,1],center=true);
    translate([0,0,1/2])
    #cube([8.2,2.3,1],center=true);
    
    translate([8.2/2,0,1/2])
    #cube([8.2,1.1,1],center=true);    
        
    translate([8.2/2+0.2/2,0,2.6/2])
    #cube([0.2,3.5,2.6],center=true); 
    }

    //pegs
    translate([0,8.2/2+1.5/2-0.2,1.5/2-0.0]) //-0.3
        cube([1.5,1.5,1.5], center=true);
    
    translate([0,8.2/2+1.5/2-0.2-0.3,1.5/2-0.3+0.7])
    rotate([60,0,0])        
    cube([1.5/3,1.5,1.5], center=true);
  
   
    rotate([0,0,180]){
            translate([0,8.2/2+1.5/2-0.2,1.5/2-0.0]) //-0.3
        cube([1.5,1.5,1.5], center=true);
    
    translate([0,8.2/2+1.5/2-0.2-0.3,1.5/2-0.3+0.7])
    rotate([60,0,0])        
    cube([1.5/3,1.5,1.5], center=true);
    } 
    
    //clamps
    //
    difference(){
        union(){
    difference(){            
    translate([0,0,2.3/2])
    cube([8.2,4.5,2.3],center=true);
     cylinder(d=8.2,h=2.3, $fn=80);    
    }
            hull(){
    translate([8.2/2+0.5/2,0,1.4/2])
    cube([0.5, 4.5,1.4], center=true);
    //
    translate([8.2/2+1.3/2,0,0.3/2])
    cube([1.3, 4.5,0.3], center=true);
            }
        }
    translate([8.2/2,0,1/2+0.5])
    #cube([8.2,2.3,1],center=true);
    translate([0,0,1/2])
    #cube([8.2,2.3,1],center=true);
    translate([8.2/2,0,1/2])
    #cube([8.2,1.1,1],center=true);    
        
    translate([8.2/2+0.2/2,0,2.6/2])
    #cube([0.2,3.5,2.6],center=true);        
        
    }

    rotate([0,0,180])
    difference(){
        union(){
    difference(){            
    translate([0,0,2.3/2])
    cube([8.2,4.5,2.3],center=true);
     cylinder(d=8.2,h=2.3, $fn=60);    
    }
            hull(){
    translate([8.2/2+0.5/2,0,1.4/2])
    cube([0.5, 4.5,1.4], center=true);
    //
    translate([8.2/2+1.3/2,0,0.3/2])
    cube([1.3, 4.5,0.3], center=true);
            }
        }
    translate([8.2/2,0,1/2+0.5])
    #cube([8.2,2.3,1],center=true);
    translate([0,0,1/2])
    #cube([8.2,2.3,1],center=true);
    translate([8.2/2,0,1/2])
    #cube([8.2,1.1,1],center=true);    
        
    translate([8.2/2+0.2/2,0,2.6/2])
    #cube([0.2,3.5,2.6],center=true);        
        
    }
    
    
    /////////////////////////////////////////77
    //main tube
    if (function_stem == 0){
    translate([0,0,2.3])
    difference()
    {
        //outer cylinder
        cylinder(h=height, d=diam, $fn=80);
        //inner cylinder
        translate([0,0,height-sq_height])
        cylinder(h=sq_height, d=diam-2*thick, $fn=80);
        
        //inner cylinder
        //translate([0,0,height-sq_height])
        //cylinder(h=sq_height, d=diam-2*thick, $fn=60);
    
        
        //inner square
        rotate([0,0,45])
        translate([0,0, (height-sq_height)/2])
        cube([sq_side,sq_side, height-sq_height], center=true);
        
}
}
    else if (function_stem==1){
        translate([0,0,10.5+2.7/2])
        cube([1.2, 9.2, 2.7],center=true);
        difference(){
        translate([0,0,10.5/2])
        cube([1.4, 10.7,10.5],center=true);
     
    translate([0,0,2.3/2])
    cube([8.2,4.5,2.3],center=true);
     cylinder(d=8.2,h=2.3, $fn=60);    
    
        }
        
    }
}

module key_pin(){
    
    //key pin
    translate([0,0,1.5+1])
    cube([3,3,3],center=true);       //pin squared body
    translate([0,0,1.5+1])
    cube([3.2,3.2,0.5],center=true); //a little wider section

    cyl_offset = 4;
    cyl_h=7-cyl_offset;    
    translate([0,0,cyl_offset])
    cylinder(r=1.41*1.5,h=cyl_h, $fn=60);//cylindrical part

    base_offset = 5.6;
    base_h=7-base_offset;
    translate([0,0,base_offset])              
    cylinder(r=3.5,h=base_h, $fn=60);       //reinforcement base
}

module show_examples(){
    key_y=18.2;
    
key(row=1);
translate([0,-key_y,0])
key(row=2);
translate([0,-key_y*2,0])
key(row=3);
translate([0,-key_y*3,0])
key(row=4);
translate([0,-key_y*4,0])
key(row=5);
    
//TAB key row 2
translate([key_y+28,0 ,0])
key(width=28, row=2 );

//CTRL key row 3 with retainers
translate([key_y+28,-1.5*key_y ,0]){
key(width=32.3, retainer=true, row=3);
translate([-10,-15,0])
retainer_hinge();
translate([10,-15,0])
retainer_hinge();
}
//big shift (left)
//key(width=41.9, retainer=true, row=4);
//small shift (right)
//key(width=32.3, retainer=true, row=4);

//a simple function key
translate([key_y+28*3,0 ,0])
function_key();

//a cursor key
translate([key_y+28*2.5,-3*key_y ,0])
cursor_key();

//a key stem
translate([key_y+28,-3*key_y ,0])
key_stem();

//a function key stem
translate([key_y+28,-4*key_y ,0])
key_stem(function_stem=1);


}

show_examples();

//key_pin();

//key row 1
//key();

//key row 4
//key(row=4);

//TAB key row 2
//key(width=28, row=2);

//CTRL key row 3 with retainers
//key(width=32.3, retainer=true, row=4);
//translate([-10,-20,0])
//retainer_hinge();
//translate([10,-20,0])
//retainer_hinge();

//big shift (left)
//key(width=41.9, retainer=true, row=4);
//small shift (right)
//key(width=32.3, retainer=true, row=4);

//a simple function key
//function_key();

//a cursor key
//cursor_key();

//a key stem
//key_stem(sq_side=3.2, diam=5.6, function_stem=0);

//a function key stem
//key_stem(sq_side=3.2, diam=5.6, function_stem=1);

