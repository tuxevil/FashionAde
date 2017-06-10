<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<IEnumerable<FashionAde.Core.FashionFlavor>>" %>
<%@ Import Namespace="FashionAde.Core.FlavorSelection"%>
<%@ Import Namespace="FashionAde.Web.Controllers.MVCInteraction" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
<title>Fashion Flavor Selection</title>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
<div id="buildYourCloset" >

    <% bool updateFlavors = (bool)ViewData["updateFlavors"]; %>

    <div class="buildClosetTitle">
        <% if(updateFlavors) 
           { %>
            <h1>Change your Fashion Flavors</h1>
            <h2>Choose any <strong>two</strong> of the silhouettes below that best describe your personal style.</h2>
        <% } else {  %>
            <h1>What´s your Fashion Flavor?</h1>
            <h2>Choose any two of the silhouettes below that best describe your personal style.</h2>
        <% } %>
    </div>
    
    <% if (!updateFlavors)
       { %>
        <img id="imgBuildSteps" src="/static/img/BuildYourCloset/step1.gif" alt="Steps" />
    <% } %>   
    
<div style="width:100%;">
<div class="fashionFlavors flavorLeft" >        
<span class="fashionFlavorTitle">Which type or types are most like you?</span>
    <div id="divFlavorSelect" class="flavorContainer">        
    
        <% using (Html.BeginForm("SelectFashionFlavor", "FlavorSelect" ))
           {
               if (Model != null)
                   foreach (var fashionFlavor in Model)
                   {
                       Html.RenderPartial("FashionFlavor", fashionFlavor);
                   } %>       
    </div>    
    <div id="btnBuildNext" class="divButtonBig" style="clear:both; ">NEXT</div>
     <% } %>     
</div>

<div class="fashionFlavors flavorRigth">
    <span class="fashionFlavorTitle">Not Sure?</span>
    <div class="flavorContainer"  style="float:left;">
        <a class="startQuiz" shape="rect"  href="#QuizStep1" title="Take our quiz to pinpoint your style" alt="">
            <img id="imgQuiz"  src="/static/img/BuildYourCloset/img_take_our_quiz.jpg"  alt="Take Our Quiz!" class="startQuizButtonBanner" />
        </a> 
    </div>
    <a class="startQuiz" shape="rect"  href="#QuizStep1" title="Take our quiz to pinpoint your style" alt="" style="display:inline; text-decoration: none;" >
        <div id="imgStartQuiz" class="startQuizButton divButtonBig" style="margin-left: 120px; margin-top: 0px;" >NEXT</div>
    </a>
</div>

</div>
<br style="clear:both;" /><br style="clear:both;" />

</div>

<div id="divQuizAll">     
    <div id="QuizStep1" class="quizPopup">            
        <div class="quizHeader">            
            <img src="/static/img/quiz_logo.jpg" class="quizLogo" alt="" style="" />
            <div style="width:350px; ">
                <span class="quizTitle">WELCOME TO THE QUIZ</span>
                <span class="quizSubTitle">Choose the photo that best represent the clothes you actually wear each day:</span>
            </div>
        </div>
        <div class="quizContent">
            <div class="quizContentItems">
                <%  int i = 0;
                    List<StylePhotograph> stylePhotographs = (List<StylePhotograph>) ViewData["StylePhotograph"];
                    if(stylePhotographs != null)
                        foreach (var stylePhotograph in stylePhotographs)
                        {
                            if (i == 4) %> 
            </div>
            <div class="quizContentItems"> 
                <%              Html.RenderPartial("StylePhotograph", stylePhotograph);
                            i++;
                        } %>
            </div>
        </div>
                    
        <div class="quizFooter">
            <img src="/static/img/BuildYourCloset/progress_step1.gif" alt="Step 1" class="quizProgress" />            
            <div id="lnkQuizStep2" href="#QuizStep2" style="float:right; margin-right: 20px;" class="divButtonBig" >NEXT</div>
        </div>        
    </div>    

    <div id="QuizStep2" class="quizPopup" >
        <div class="quizHeader">
            <img src="/static/img/quiz_logo.jpg" class="quizLogo" alt="" style="" />
            <div>        
                <span class="quizTitle">WELCOME TO THE QUIZ</span>        
                <span class="quizSubTitle">Which set of stores best reflects where you like to shop?</span>
            </div>
        </div>

        <div class="quizContent">
            <div class="quizContentItems">
                <%  int j = 0;
                    List<BrandSet> brandSets = (List<BrandSet>) ViewData["BrandSet"];
                    if(brandSets != null)
                        foreach (var brandSet in brandSets)
                        {
                            if (j == 4) %> 
                </div>
                <div class="Quiz_Content_Item2"> 
                <%              Html.RenderPartial("BrandSet", brandSet);
                            j++;
                        } %>
            </div>
        </div>
                    
        <div class="quizFooter">            
            <img src="/static/img/BuildYourCloset/progress_step2.gif" alt="Step 2" class="quizProgress" />
            <div id="lnkQuizStep3" href="#QuizStep3" style="float:right;" class="divButtonBig" >NEXT</div>
            <div id="lnkPreviousStep1" href="#QuizStep1" style="float:right; margin-right: 20px;" class="divButtonBig" >PREVIOUS</div>
        </div>
    </div>

    <div id="QuizStep3" class="quizPopup" >
        <div class="quizHeader">
            <img src="/static/img/quiz_logo.jpg" class="quizLogo" alt="" style="" />
            <div>  
                <span class="quizTitle">WELCOME TO THE QUIZ</span>                      
                <span class="quizSubTitle">Which of this group of words best describe your favorite look?</span>
            </div> 
        </div>

        <div class="quizContent">
            <div>
                <%  int k = 0;
                    List<Wording> wordings = (List<Wording>) ViewData["Wording"];
                    foreach (var wording in wordings)
                    {
                        if (k == 4)
                        %> </div><div class="quizContentBelow"> <%                        
                            Html.RenderPartial("Wording", wording);                    
                        k++;
                    } %>
            </div>
        </div>
            
        <div class="quizFooter">
            <img src="/static/img/BuildYourCloset/progress_step3.gif" alt="Step 3" class="quizProgress" />
            <div id="lnkQuizComplete" href="#QuizComplete" style="float:right;" class="divButtonBig" >NEXT</div>
            <div id="lnkPreviousStep2" href="#QuizStep2" style="float:right; margin-right: 20px;" class="divButtonBig" >PREVIOUS</div>
        </div>
        
    </div>
        
    <div id="QuizComplete" class="quizPopup" >
        <div class="quizHeader">
            <img src="/static/img/quiz_logo.jpg" class="quizLogo" alt="" style="" />
            <div style="width:350px; ">                
                <span class="quizTitle">WELCOME TO THE QUIZ</span>
                <span class="quizSubTitle">Given your responses the fashion flavors that best match with you are:</span>
            </div> 
        </div>

        <div class="quizComplete">
            <div class="quizCompleteHeader">Your Fashion Flavor results</div>
            <div style="margin-top:15px; float:left;" >
                <div class="quizCompleteBoxes" >
                    <div style="width:200px;" class="quizCompleteText">Based on your answers, you Fashion Flavor is:</div>
                    <div class="quizCompleteWhiteSpace">
                        <div id="Result1" class="quizCompleteResult">
                            <img id="FashionFlavor1Image" class="quizCompleteFashionFlavorImage" /><br />
                            <span id="FashionFlavor1Name"></span>
                        </div>
                        <div id="Result2" class="quizCompleteResult" >
                            <img id="FashionFlavor2Image" class="quizCompleteFashionFlavorImage"/><br />
                            <span id="FashionFlavor2Name"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>            
            
        <div class="quizFooter">
            <img src="/static/img/BuildYourCloset/progress_step4.gif" alt="Step 4" class="quizProgress" />
            <%if(updateFlavors) { %>
                <% using (Html.BeginForm("QuizCompleted", "FlavorChange", FormMethod.Post, new { id = "QuizForm" }))
                   { %>
                <input type="hidden" id="Flavor1Id" name="Flavor1Id" />
                <input type="hidden" id="Flavor2Id" name="Flavor2Id" />
                
                <div id="btnContinueBuilding" style="float:right" class="divButtonBig" >CONTINUE</div>
                <div id="lnkRestart" href="#QuizStep1" style="float:right; margin-right: 20px;" class="divButtonBig" >RESTART</div>
                
                <%} %>
            <% } else { %>
                <% using (Html.BeginForm("QuizCompleted", "FlavorSelect", FormMethod.Post, new { id="QuizForm" }))
                   { %>  
                <input type="hidden" id="Flavor1Id" name="Flavor1Id" />
                <input type="hidden" id="Flavor2Id" name="Flavor2Id" />
                
                <div id="btnContinueBuilding" style="float:right" class="divButtonBig" >CONTINUE</div>
                <div id="lnkRestart" href="#QuizStep1" style="float:right; margin-right: 20px;" class="divButtonBig">RESTART</div>
                
                <% } %>            
            <%} %>
            
            
        </div>
        
    </div>
</div> 

<div id="HiddenFields">
    <input type="hidden" id="Flavor1Name" />
    <input type="hidden" id="Flavor1Image" />
    <input type="hidden" id="Flavor1Result" />
    <input type="hidden" id="Flavor2Name" />
    <input type="hidden" id="Flavor2Image" />
    <input type="hidden" id="Flavor2Result" />
</div>

</asp:Content>
<asp:Content ID="contentScripts" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
<script type="text/javascript">
    var resPath = '<% = Resources.GetFlavorsPath() %>';
</script>
<script type="text/javascript" src="/static/js/flavorSelect.js"></script>
</asp:Content>