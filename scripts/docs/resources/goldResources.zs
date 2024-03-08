// import mods.sdmbestiary.bestiary.BestiaryUtils;
// import mods.sdmbestiary.bestiary.api.content.tab.TextTab;
// import crafttweaker.api.text.Component;
// import mods.sdmbestiary.bestiary.api.content.InfoContent;
// import mods.sdmbestiary.bestiary.api.content.info.HeaderInfo;
// import mods.sdmbestiary.bestiary.api.content.info.TextInfo;
// import mods.sdmbestiary.bestiary.api.content.info.ImageInfo;
// import mods.sdmbestiary.bestiary.api.content.info.ButtonInfo;
// import mods.sdmbestiary.bestiary.api.content.info.ButtonItemInfo;
// import mods.sdmbestiary.bestiary.api.content.tab.ItemTab;
// import mods.sdmbestiary.bestiary.api.content.tab.TextFieldTab;
// import mods.sdmbestiary.bestiary.api.content.tab.Group;
// import mods.sdmbestiary.bestiary.api.content.graphics.DrawColor;
// import mods.sdmbestiary.bestiary.api.content.graphics.DrawReact;
// import mods.sdmbestiary.bestiary.api.content.info.EntityInfo;



// var tab = new TextTab(Component.literal("Название вкладки"), "tab_id");
// // tab.dependence = "66E4E9F7CBF8EFFB";

// var tabPanel = new InfoContent(panel => {
//     panel.space = 0;

//     panel.addContent(new TextInfo(textInfo => {
//         textInfo.addLine(Component.literal("Таинственная сущность. Похоже та то что она умеет телепортироваться в пространстве."));
//         textInfo.addLine(Component.literal("Не любит воду, так как похоже на то что она наносит вредит сущности. "));
//         textInfo.addPos(42, 20);
//         textInfo.space = 10;
//         textInfo.setSize(280, 45);
//     }));
// });

// tab.addInfoContent(tabPanel);
// BestiaryUtils.createGroup(tab);


// public class goldResources{

//     public static newTab() as void{
//         var tab = new TextTab(Component.literal("Эндермен"), "endermen");
//         var tabInfo = new InfoContent(panel => {
//             panel.space = 0;

//             panel.addContent(new EntityInfo(entity => {
//                 entity.entityType = <entitytype:minecraft:enderman>;
//                 entity.size = 20;
//                 entity.addPos(20, 60);
//                 entity.yaw = -30;
//             }));
//             panel.addContent(new DrawColor(color => {
//                 color.setColor(49,42,60);
//                 color.setSize(40,65);
//                 color.addPos(1,1);
//             }));
//             panel.addContent(new DrawReact(color => {
//                 color.setColor(84,74,100);
//                 color.setSize(40,65);
//                 color.addPos(1,1);
//             }));
//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("Эндермен").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(5, -7);
//                 header.size = 1.2f;
//                 header.isDrawBackGround = false;
//                 header.setSize(83, 8);
//             }));  
//             panel.addContent(new DrawColor(color => {
//                 color.setColor(49,42,60);
//                 color.setSize(267,45);
//                 color.addPos(41,20);
//             }));    
//             panel.addContent(new DrawReact(color => {
//                 color.setColor(84,74,100);
//                 color.setSize(268,47);
//                 color.addPos(40,19);
//             }));      
//             panel.addContent(new TextInfo(textInfo => {
//                 textInfo.addLine(Component.literal("Таинственная сущность. Похоже та то что она умеет телепортироваться в пространстве."));
//                 textInfo.addLine(Component.literal("Не любит воду, так как похоже на то что она наносит вредит сущности. "));
//                 textInfo.addPos(42, 20);
//                 textInfo.space = 10;
//                 textInfo.isDrawBackGround = false;
//                 textInfo.setSize(280, 45);
//             }));
//         });

//         tab.addInfoContent(tabInfo);
//         BestiaryUtils.createGroup(tab);
//     }

//     public static goldOre() as void{
//         var goldOreGroup = new ItemTab(Component.literal("Рудное Золото"), <item:minecraft:raw_gold>, "goldOre");
//         goldOreGroup.setIcon(BestiaryUtils.createIcon(<item:minecraft:raw_gold>));
//         var goldOreInfo = new InfoContent(panel => {
//             panel.space = 10;
//             panel.addContent(new ImageInfo(image => {
//                 image.icon = BestiaryUtils.createIcon(<resource:ftbteams:textures/accept.png>);
//                 image.isDrawBackGround = false;
//                 image.weight = 48;
//                 image.height = 48;
//                 image.addPos(1,1);
//             }));
//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("Рудное Золото.").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(51, -8);
//                 header.isDrawBackGround = false;
//                 header.setSize(83, 8);
//             }));  

//             panel.addContent(new TextInfo(textInfo => {
//                 textInfo.addLine(Component.literal("Рессурс который сам по себе не бесполезен."));
//                 textInfo.addLine(Component.literal("Чтобы использовать его нужно обработать."));
//                 textInfo.addPos(51, -6);
//                 textInfo.isDrawBackGround = false;
//                 textInfo.setSize(400, 35);
//             }));

//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("Способ получения").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(2, 0);
//                 header.isDrawBackGround = false;
//                 header.setSize(48, 8);
//             })); 

//             panel.addContent(new ButtonItemInfo(button => {
//                 button.item = <item:minecraft:gold_ore>;
//                 button.clickURL = "1";
//                 button.w = 70;
//                 button.addPos(1, 0);
//                 button.componentText.add(<item:minecraft:gold_ore>.hoverName);
//             }));
//             panel.addContent(new ButtonItemInfo(button => {
//                 button.item = <item:minecraft:deepslate_gold_ore>;
//                 button.clickURL = "1";
//                 button.addPos(85, -26);
//                 button.componentText.add(<item:minecraft:deepslate_gold_ore>.hoverName);
//             }));
//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("Используется").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(2, -34);
//                 header.isDrawBackGround = false;
//                 header.setSize(58, 8);
//             })); 

//             panel.addContent(new ButtonItemInfo(button => {
//                 button.item = <item:minecraft:gold_ingot>;
//                 button.clickURL = "goldIngot";
//                 button.w = 70;
//                 button.addPos(1, -35);
//                 button.componentText.add(<item:minecraft:gold_ingot>.hoverName);
//             }));
//             panel.addContent(new ButtonItemInfo(button => {
//                 button.item = <item:minecraft:raw_gold_block>;
//                 button.clickURL = "https://saudade-studio.ru/";
//                 button.addPos(92, -61);
//                 button.componentText.add(<item:minecraft:raw_gold_block>.hoverName);
//             }));

//         });

//         goldOreGroup.addInfoContent(goldOreInfo);
//         BestiaryUtils.createGroup(goldOreGroup);
//     }

//     public static goldIngot() as void{
//         var goldOreGroup = new TextTab(Component.literal("Золотой Слиток"), "goldIngot");
//         var goldOreInfo = new InfoContent(panel => {
//             panel.space = 0;


//             // panel.addContent(new DrawColor(color => {
//             //     color.setColor(20,80,20);
//             //     color.setSize(400,500);
//             //     color.addPos(5,5);
//             // }));

//             panel.addContent(new ImageInfo(image => {
//                 image.icon = BestiaryUtils.createIcon(<item:minecraft:gold_ingot>);
//                 image.isDrawBackGround = false;
//                 image.weight = 48;
//                 image.height = 48;
//                 image.addPos(1,1);
//             }));
//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("Золотой Слиток").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(51, 0);
//                 header.isDrawBackGround = false;
//                 header.setSize(83, 8);
//             }));  

//             // panel.addContent(new TextInfo(textInfo => {
//             //     textInfo.addLine(Component.literal("Один из ценнейших материалов, который имеет превосходную проводимость и магический потенциал."));
//             //     textInfo.addLine(Component.literal("В некоторых измерениях используется как валюта."));
//             //     textInfo.addPos(51, -6);
//             //     textInfo.space = 10;
//             //     textInfo.isDrawBackGround = false;
//             //     textInfo.setSize(300, 35);
//             // }));

//             // panel.addContent(new HeaderInfo(header => {
//             //     header.text = Component.literal("Способ получения").withStyle(<constant:minecraft:formatting:gold>);
//             //     header.addPos(2, 0);
//             //     header.isDrawBackGround = false;
//             //     header.setSize(100, 8);
//             // })); 

//             // panel.addContent(new ButtonItemInfo(button => {
//             //     button.item = <item:minecraft:raw_gold>;
//             //     button.clickURL = "goldOre";
//             //     button.w = 70;
//             //     button.addPos(1, 0);
//             //     button.componentText.add(<item:minecraft:raw_gold>.hoverName);
//             // }));
//             // panel.addContent(new HeaderInfo(header => {
//             //     header.text = Component.literal("Используется").withStyle(<constant:minecraft:formatting:gold>);
//             //     header.addPos(2, 0);
//             //     header.isDrawBackGround = false;
//             //     header.setSize(58, 8);
//             // })); 

//             // panel.addContent(new ButtonItemInfo(button => {
//             //     button.item = <item:minecraft:golden_sword>;
//             //     button.clickURL = "1";
//             //     button.w = 70;
//             //     button.addPos(1, -19);
//             //     button.componentText.add(<item:minecraft:golden_sword>.hoverName);
//             // }));
//             // panel.addContent(new ButtonItemInfo(button => {
//             //     button.item = <item:minecraft:golden_pickaxe>;
//             //     button.clickURL = "1";
//             //     button.addPos(92, -45);
//             //     button.componentText.add(<item:minecraft:golden_pickaxe>.hoverName);
//             // }));

//         });
//         goldOreGroup.addInfoContent(goldOreInfo);
//         BestiaryUtils.createGroup(goldOreGroup);
//     }

//     public static test() as void{
//         var groupGP = new Group(group => {
//             group.component = Component.literal("Hello");
//             group.id = "testID";
//         });
//         var goldOreGroup = new TextTab(Component.literal("У меня своё название"), "sdmbestiaryTeam");
//         goldOreGroup.group = groupGP;
//         var goldOreInfo = new InfoContent(panel => {
//             panel.space = 0;

//             panel.addContent(new EntityInfo(entity => {
//                 entity.entityType = <entitytype:minecraft:witch>;
//                 entity.size = 20;
//                 entity.addPos(20, 100);
//                 entity.yaw = -30;
//             }));

//             panel.addContent(new EntityInfo(entity => {
//                 entity.entityType = <entitytype:minecraft:witch>;
//                 entity.size = 20;
//                 entity.addPos(50, 100);
//                 entity.yaw = 30;
//             }));

//             panel.addContent(new ImageInfo(image => {
//                 image.icon = BestiaryUtils.createIcon(<item:minecraft:diamond_sword>.withTag({Enchantments: [{lvl: 1, id: "minecraft:knockback"}]}));
//                 image.isDrawBackGround = false;
//                 image.weight = 48;
//                 image.height = 48;
//                 image.addPos(1,1);
//             }));
//             panel.addContent(new HeaderInfo(header => {
//                 header.text = Component.literal("test").withStyle(<constant:minecraft:formatting:gold>);
//                 header.addPos(51, 1);
//                 header.isDrawBackGround = false;
//                 header.setSize(83, 8);
//             }));  

//             panel.addContent(new TextInfo(textInfo => {
//                 textInfo.addLine(Component.literal("Один из ценнейших материалов, который имеет превосходную"));
//                 textInfo.addLine(Component.literal("проводимость и магический потенциал."));
//                 textInfo.addLine(Component.literal("В некоторых измерениях используется как валюта."));
//                 textInfo.addPos(51, 10);
//                 textInfo.isDrawBackGround = false;
//                 textInfo.setSize(400, 39);
//             }));

//         });
//         goldOreGroup.addInfoContent(goldOreInfo);
//         BestiaryUtils.createGroup(goldOreGroup);
//     }



//     public static init() as void{
//         BestiaryUtils.isHideTittle(true);
//         BestiaryUtils.setTittle(Component.literal("Привет это заголовок !"));
//         newTab();
//         goldOre();
//         goldIngot();
//         test();
//     }
// }

// goldResources.init();