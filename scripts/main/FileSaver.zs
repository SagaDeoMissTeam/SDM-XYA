import mods.sdmcrtplus.utils.file.File;
import mods.sdmcrtplus.utils.file.FileWriter;
import mods.sdmcrtplus.utils.file.FileUtils;
import mods.sdmcrtplus.utils.file.Path;
import crafttweaker.api.data.MapData;
import mods.sdmcrtplus.utils.file.FileReader;
import mods.sdmcrtplus.utils.file.streams.FileInputStream;
import mods.sdmcrtplus.utils.file.streams.BufferedReader;
import mods.sdmcrtplus.utils.file.streams.PrintWriter;
import crafttweaker.api.game.Server;

public class ReplacerFileSaver{
    public static var dir as string = FileUtils.getScriptsDirectory().toString();

    public static save(name as string, data as MapData, uuid as string, server as Server) as void{
        this.clearFile(name, uuid, server);
        var dataFile as PrintWriter;
        try{
            dataFile = new PrintWriter(new File(FileUtils.getStructureDirectory(server, <resource:sdm:${name}>).toString() + "/" + name + "-" + uuid + ".snbt"));
            for mData in data[name as string]{
                var ch as string = data[name as string][mData as string] as string;
                dataFile.println((mData as string + " | " + ch) as string);
            }
        }
        dataFile.flush();
        dataFile.close();
    }

    protected static clearFile(name as string, uuid as string, server as Server) as void{
        try{
            var fwOb as FileWriter = new FileWriter(new File(FileUtils.getStructureDirectory(server, <resource:sdm:${name}>).toString() + "/" + name + "-" + uuid + ".snbt"), false); 
            var pwOb as PrintWriter = new PrintWriter(new File(FileUtils.getStructureDirectory(server, <resource:sdm:${name}>).toString() + "/" + name + "-" + uuid + ".snbt"));
            pwOb.flush();
            pwOb.close();
            fwOb.close();
        }

    }
}