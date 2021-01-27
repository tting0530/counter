-----------------------------------------------------------------------------------------
--
-- counter.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--1) 게임에 사용될 랜덤함수 미리 초기화
   math.randomseed(os.time())
--2) widget 라이브러리 추가(아래서 사용할 것임)
local widget = require("widget")
local physics = require("physics")
--4) GUI 요소들 선언 
local background--배경
local gameUI = {}--화면UI
local customer = {}--손님 이미지
local menu = {}--메뉴 이미지
local customer_order--손님 랜덤 지정
local customer_num--주문 메뉴 랜덤 지정

local bubble = {}--말풍선
---------------------------
local hpDownNum = 10--길이에 맞춰 조절해야함
local hpXDownNum = 5
local mentalityDownNum = 10
local mentalitXyDownNum = 5

function scene:create( event )
   local sceneGroup = self.view

   background = display.newImageRect("image/background.png",  display.contentWidth, display.contentHeight)
   background.x, background.y = display.contentWidth/2, display.contentHeight/2
--씬 이동부분--
    local function toCook()

      composer.gotoScene("cook")
   end

   --카운터
   gameUI[1] = display.newImageRect("image/counter.png",  display.contentWidth, display.contentHeight)
   gameUI[1].x, gameUI[1].y = display.contentWidth/2, display.contentHeight/2

   --hp
   local hpDownNum = 10--길이에 맞춰 조절해야함
   local hpXDownNum = 5
   gameUI[2] = display.newImageRect("image/hp.png", 350, 50)
   gameUI[2].x, gameUI[2].y = display.contentWidth-1090, display.contentHeight-650
   function hpDown()
      gameUI[2].x = gameUI[2].x - hpXDownNum
      gameUI[2].width = gameUI[2].width - hpDownNum
   end

   --정신력
   local mentalityDownNum = 10
   local mentalitXyDownNum = 5
   gameUI[3] = display.newImageRect("image/mentality.png", 350, 50)
   gameUI[3].x, gameUI[3].y = display.contentWidth-1090, display.contentHeight-600
   function mentalityDown()
      gameUI[3].x = gameUI[3].x - mentalitXyDownNum
      gameUI[3].width = gameUI[3].width - mentalityDownNum
   end
   function mentalityUp()
      gameUI[3].x = gameUI[3].x + mentalitXyDownNum
      gameUI[3].width = gameUI[3].width + mentalityDownNum
   end
   timer.performWithDelay( 1000, hpDown, 10)
   timer.performWithDelay( 1000, mentalityDown, 10)
   --timer.performWithDelay( 900, mentalityUp, 10)--정신력up

   --원형 시계(?)
   gameUI[4] = display.newImageRect("image/time.png",  200, 200)
   gameUI[4].x, gameUI[4].y = display.contentWidth-1200, display.contentHeight-650

   --레시피북
   gameUI[5] = widget.newButton({
      defaultFile = "image/recipe.png", overFile = "image/setting.png",
      width = 80, height = 80, onPress = inputEvent -- 버튼을 누르면 inputEvent
   })
   gameUI[5].x, gameUI[5].y = display.contentWidth-200, display.contentHeight-650
   gameUI[5].name = "recipe"

   --달력
   gameUI[6] = display.newImageRect("image/calendar.png",  100, 100)
   gameUI[6].x, gameUI[6].y = display.contentWidth-70, display.contentHeight-650

   --설정(메뉴)
   gameUI[7] = widget.newButton({
      defaultFile = "image/setting.png", overFile = "image/setting.png",
      width = 70, height = 70, onPress = inputEvent -- 버튼을 누르면 inputEvent
   })
   gameUI[7].x, gameUI[7].y = display.contentWidth-50, display.contentHeight-50
   gameUI[7].name = "setting"

   --전환
   gameUI[8] = widget.newButton({
      defaultFile = "image/arrow.png", overFile = "image/setting.png",
      width = 80, height = 80, onPress = toCook -- 버튼을 누르면 inputEvent
   })
   gameUI[8].x, gameUI[8].y = display.contentWidth-100, display.contentHeight/2
   gameUI[8].name = "arrow"

   --손님 이미지 분할
   customer[0] = graphics.newImageSheet("image/customer.png", {width = 277, height = 719, numFrames = 3})

   for i = 1, 3, 1 do
      customer[i] = {}
      customer[i][1] = display.newImageRect(customer[0], 1, 279, 719)
      customer[i][2] = display.newImageRect(customer[0], 2, 279, 719)
      customer[i][3] = display.newImageRect(customer[0], 3, 279, 719)
   end

   for i = 1, 3, 1 do
      for j = 1, 3, 1 do
         customer[i][j].alpha = 0
         customer[i][j].x, customer[i][j].y = display.contentWidth/2 - 400 + 400 * (i-1), display.contentHeight/2+200
      end
   end

   --말풍선
   for i=1, 3, 1 do
   bubble[i] = display.newImageRect("image/bubble.png",  180, 100)
   bubble[i].x, bubble[i].y = display.contentWidth/2-80, display.contentHeight/2-100
   bubble[i].alpha = 0
   end
--메뉴 이미지 분할
   menu[0] = graphics.newImageSheet("image/menu.png", {width = 666, height = 287, numFrames = 3})

   for i = 1, 3, 1 do
      menu[i] = {}
      menu[i][1] = display.newImageRect(menu[0], 1, 150, 40)
      menu[1].name = "꼬마김밥"
      menu[i][2] = display.newImageRect(menu[0], 2, 150, 40)
      menu[i][3] = display.newImageRect(menu[0], 3, 150, 40)
   end

   for i = 1, 3, 1 do
      for j = 1, 3, 1 do
         menu[i][j].alpha = 0
         menu[i][j].x, menu[i][j].y = display.contentWidth/2 - 400 + 400 * (i-1), display.contentHeight/2+200
      end
   end
   --손님 오는 함수
   function customerOrder()
      for i = 1, 3, 1 do
         customer_num = math.random(1,3)--손님 랜덤
         customer_order = math.random(1, 3)--주문메뉴 랜덤
         --order[i] = menu[customer_order].name
         --print(order)
         customer[i][customer_num].alpha = 1
         bubble[i].x = customer[i][customer_num].x - 100
         bubble[i].alpha = 1
         menu[i][customer_order].alpha = 1
         menu[i][customer_order].x, menu[i][customer_order].y = bubble[i].x, bubble[i].y
      end
   end
   customerOrder()
--매출
   local moneytext = display.newText("00000원", 1000, 60)
   local price = 1
   moneytext:setFillColor(1)
   moneytext.size = 25
   local function moneySum(order)
      for i=1, 3, 1 do
         if order.name == menu[i] then
            local sales = sales + 100
            print(sales)
         end
      end
      moneytext.text = string.format("%05d원", slaes)   
   end

   --달력 1월 ~ 12월
   local monthText = display.newText("1月", 1200, 60)
   local month = 1
   monthText:setFillColor(1)
   monthText.size = 25
   function time(event)
      month = month + 1
      local monthPrint = string.format("%d月", month)
      monthText.text = monthPrint        
   end
   timer.performWithDelay( 1000, time, 11) 

   local finish1 = display.newImage ("image/menu_1.PNG", 200, 50)
   finish1.x = display.contentWidth/2
   finish1.y =  display.contentHeight/2 +250
   finish1.name = "꼬마김밥"
   function finish1:touch( event )--드래그하고 메뉴위치에서 멈추면 투명해지게하는 함수
      --같은 메뉴이면 돈 올라가게끔..
       if event.phase == "began" then

       self.markX = self.x    -- store x location of object
       self.markY = self.y    -- store y location of object

      elseif event.phase == "moved" then

      local x = (event.x - event.xStart) + self.markX
      local y = (event.y - event.yStart) + self.markY

       self.x, self.y = x, y   
       elseif event.phase == "ended" then
         for i=1, 3, 1 do
            for j=1, 3, 1 do
               if self.x > menu[i][j].x - menu[i][j].width/2 and self.x < menu[i][j].x + menu[i][j].width/2 
                  and self.y> menu[i][j].y - menu[i][j].height/2 and self.y < menu[i][j].y + menu[i][j].height/2 then--정확한 사이즈 
                  event.target.alpha = 0
                  if menu[i][j].name == event.target.name then
                     moneySum(menu[i][j])
                  end
               end
            end
         end
      end

   return true
end

--notesGroup:insert(tile1)

finish1:addEventListener("touch", finish1)

--------------------------------------------------------
local finish2 = display.newImage ("image/menu_2.PNG", 200, 50)
   finish2.x = display.contentWidth/2-400
   finish2.y =  display.contentHeight/2 +250
   finish2.name = "꼬마김밥"
   function finish2:touch( event )
       if event.phase == "began" then

       self.markX = self.x    -- store x location of object
       self.markY = self.y    -- store y location of object

      elseif event.phase == "moved" then

      local x = (event.x - event.xStart) + self.markX
      local y = (event.y - event.yStart) + self.markY

       self.x, self.y = x, y   
       elseif event.phase == "ended" then
         for i=1, 3, 1 do
            for j=1, 3, 1 do
               if self.x > menu[i][j].x - menu[i][j].width/2 and self.x < menu[i][j].x + menu[i][j].width/2 
                  and self.y> menu[i][j].y - menu[i][j].height/2 and self.y < menu[i][j].y + menu[i][j].height/2 then--정확한 사이즈 
                  event.target.alpha = 0
                  if menu[i][j].name == event.target.name then
                     moneySum(menu[i][j])
                  end
               end
            end
         end
      end

   return true
end

--notesGroup:insert(tile1)

finish2:addEventListener("touch", finish2)
-----------------------------------------------------------------------

local finish3 = display.newImage ("image/menu_3.PNG", 200, 50)
   finish3.x = display.contentWidth/2+400
   finish3.y =  display.contentHeight/2 +250
   finish3.name = "꼬마김밥"
   function finish3:touch( event )
       if event.phase == "began" then

       self.markX = self.x    -- store x location of object
       self.markY = self.y    -- store y location of object

      elseif event.phase == "moved" then

      local x = (event.x - event.xStart) + self.markX
      local y = (event.y - event.yStart) + self.markY

       self.x, self.y = x, y   
       elseif event.phase == "ended" then
         for i=1, 3, 1 do
            for j=1, 3, 1 do
               if self.x > menu[i][j].x - menu[i][j].width/2 and self.x < menu[i][j].x + menu[i][j].width/2 
                  and self.y> menu[i][j].y - menu[i][j].height/2 and self.y < menu[i][j].y + menu[i][j].height/2 then--정확한 사이즈 
                  event.target.alpha = 0
                  if menu[i][j].name == event.target.name then
                     moneySum(menu[i][j])
                  end
               end
            end
         end
      end

   return true
end

--notesGroup:insert(tile1)

finish3:addEventListener("touch", finish3)
--======================================================================================================================
   sceneGroup:insert(background)

   for i = 1, 3, 1 do
      for j=1, 3, 1 do
         sceneGroup:insert(customer[i][j])
      end
   end
   for i=1, 3, 1 do
      sceneGroup:insert(bubble[i])
   end
   for i = 1, 3, 1 do
      for j = 1, 3, 1 do
      sceneGroup:insert(menu[i][j])
   end
   end

   sceneGroup:insert(gameUI[1])
   sceneGroup:insert(finish1)
   sceneGroup:insert(finish2)
   sceneGroup:insert(finish3)
   sceneGroup:insert(gameUI[8])

   end

function scene:show( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if phase == "will" then
   elseif phase == "did" then
      -- e.g. start timers, begin animation, play audio, etc.
   end   
end

function scene:hide( event )
   local sceneGroup = self.view
   local phase = event.phase
   
   if event.phase == "will" then

   elseif phase == "did" then
   end
end

function scene:destroy( event )
   local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
