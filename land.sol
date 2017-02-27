contract land{
address public owner;
uint public defaultCost;
uint public mainLandCost;

mapping(uint => mapping(uint => address))public properties;
mapping(uint => mapping(uint => address))public landContent;
mapping(uint => mapping(uint => bool))public status;
mapping(uint => mapping(uint => uint))public prices;

function land(own o){owner=o;}

function setLandPrice(uint x,uint y,uint price) returns (bool){
   if(status[x][y]){
   if(msg.sender==properties[x][y])prices[x][y]=price;
   }else{
   if(msg.sender==owner)prices[x][y]=price;
   }
      return true;
}

function setMainLandCost(uint price) returns (bool){
   if(!status[x][y]){
   if(msg.sender==owner)mainLandCost=price;
   }
      return true;
}

function setDefaultCost(uint price) returns (bool){
   if(msg.sender==owner)defaultCost=price;
   return true;
}


function buyLand(uint x,uint y)returns(bool) payable{
   if(status[x][y]){
   if(prices[x][y]>0)if(msg.value>=prices[x][y])properties[x][y]=msg.sender;
   }else{
   if(prices[x][y]>0)if(msg.value>=prices[x][y]){properties[x][y]=msg.sender;status[x][y]=true;}
   if(prices[x][y]==0)if(msg.value>=defaultCost)properties[x][y]=msg.sender;
   }
}

function setLand(uint x,uint y,address entity)returns(bool){
if(status[x][y]){
if(properties[x][y]==msg.sender){
landContent[x][y]=entity;
}else{throw;}
}else{
if(owner==msg.sender){
landContent[x][y]=entity;
}else{throw;}
}
return true;
}

function buyMainLand()returns(bool) payable{
   if(mainLandCost>0)if(msg.value>=mainLandCost){owner=msg.sender;mainLandCost=0;} 
}

function getLocation(uint x,uint y)constant returns(uint,address,bool){
return(prices[x][y],properties[x][y],status[x][y]);
}

}
