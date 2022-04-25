

   	// livechat by www.mylivechat.com/  2018-06-12

   	


	   MyLiveChat.Version =3006;
	   MyLiveChat.FirstRequestTimeout =1800;
	   MyLiveChat.NextRequestTimeout =15000;
	   MyLiveChat.SyncType ="VISIT";
	   MyLiveChat.SyncStatus ="READY";
	   MyLiveChat.SyncUserName ="Guest_94103cbc";
	   MyLiveChat.SyncResult =null;
	   MyLiveChat.HasReadyAgents =true;
	   MyLiveChat.SourceUrl ="/1/invoice/32/show-moppzlym/j42rTR8guA";
	   MyLiveChat.AgentTimeZone = parseInt("1" || "-5");
	   MyLiveChat.VisitorStatus ="VISIT";
	   MyLiveChat.UrlBase ="https://uk.mylivechat.com/livechat2/";
	   MyLiveChat.SiteUrl ="https://uk.mylivechat.com/";

   	

	   if (!MyLiveChat.AgentId) MyLiveChat.AgentId = MyLiveChat.RawAgentId;

	   MyLiveChat.Departments = [];

	   MyLiveChat.Departments.push({
		   Name:"Default",
		   Agents: [{
			   Id:'User:1',
			   Name:"admin",
			   Online:true
   			}],
		   Online:true
   		});



	   MyLiveChat.VisitorUrls = [];



   	


	   MyLiveChat.VisitorLocation ="";
	   MyLiveChat.LastLoadTime = new Date().getTime();
	   MyLiveChat.VisitorDuration =297;
	   MyLiveChat.VisitorEntryUrl ="/1/payment/32/details-p8mdftbk/j42rTR8guA";
	   MyLiveChat.VisitorReferUrl =null;

	   MyLiveChat.VisitorUrls = [];



   	
	   MyLiveChat.VisitorUrls.push("/1/payment/32/details-p8mdftbk/j42rTR8guA");
   	
	   MyLiveChat.VisitorUrls.push("/1/invoice/32/show-moppzlym/j42rTR8guA");
   	

	   MyLiveChat_Initialize();

	   if (MyLiveChat.localStorage || MyLiveChat.userDataBehavior) {
		   MyLiveChat_SyncToCPR();
	   }

   	