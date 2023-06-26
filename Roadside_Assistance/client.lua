local identifier = "Roadside_Assistance"

CreateThread(function ()
    while GetResourceState("lb-phone") ~= "started" do
        Wait(500)
    end

    local function AddApp()
        local added, errorMessage = exports["lb-phone"]:AddCustomApp({
            identifier = Roadside_Assistance,
            name = "RoadSide",
            description = "QUICK CALL A MECHANIC",
            developer = "Shady Mechanics co.",
            defaultApp = true, -- OPTIONAL if set to true, app should be added without having to download it,
            size = 59812, -- OPTIONAL in kb
            images = {"https://example.com/photo.jpg"}, -- OPTIONAL array of images for the app on the app store

            ui = "index.html", -- built version
            

            icon = "Images/Wrenches.png"
        })

        if not added then
            print("Could not add app:", errorMessage)
        end
    end

    AddApp()

    AddEventHandler("onResourceStart", function(resource)
        if resource == "lb-phone" then
            AddApp()
        end
    end)
    onServerUse = function(source) -- OPTIONAL server side function to be called when the app is opened
        local numbers = {"9075001787", "9073894058"};
        local randomElement = numbers[ math.random( 1, #numbers - 0 )];
        local chosennum = tostring(randomElement);
        local localpntable = exports["lb-phone"]:GetEquippedPhoneNumber(source);
        local localpn = tostring(localpntable);
        local mechanicisonline = exports["lb-phone"]:GetSourceFromNumber(chosennum);


        print("local pn: " .. localpn .. " | chosennum: " .. chosennum .. " | Source: " .. source);
        print(mechanicisonline)
        if mechanicisonline == false and randomElement == 1 then 
            local numbers = {"9075001787", "9073894058"};
            local randomElement = numbers[0];
            chosennum = tostring(randomElement);
            local mechanicisonline = exports["lb-phone"]:GetSourceFromNumber(chosennum);
            print(mechanicisonline);
        end;
            
        if mechanicisonline == false and randomElement == 0 then 
            local numbers = {"9075001787", "9073894058"};
            local randomElement = numbers[1];
            chosennum = tostring(randomElement);
            local mechanicisonline = exports["lb-phone"]:GetSourceFromNumber(chosennum);
            print(mechanicisonline);
        end;
        
            if mechanicisonline ~= false then
            local callID = exports["lb-phone"]:CreateCall({ 
                    print("call Made succesfully"),
                    phoneNumber = localpntable,
                    source = source
                
                    }, chosennum, {

                        requirePhone = false,
                        hideNumber = false

                    });
            
        end
    end;
end
)





