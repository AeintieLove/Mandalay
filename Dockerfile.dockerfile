# Tomcat image ကို သုံးပါမယ် (Java 17 support ပါတာ)
FROM tomcat:11.0-jdk17

# ပုံမှန် Tomcat ရဲ့ default webapps တွေကို ရှင်းထုတ်ပါမယ်
RUN rm -rf /usr/local/tomcat/webapps/*

# သင့် Project ရဲ့ .war file ကို Tomcat ထဲ ကူးထည့်ပါမယ်
# (မှတ်ချက်: 'YourProjectName.war' နေရာမှာ သင့် project war file နာမည်ထည့်ပါ)
COPY ./Mandalay.war /usr/local/tomcat/webapps/ROOT.war

# Port 8080 ကို ဖွင့်ပါမယ်
EXPOSE 8080

# Tomcat ကို run ပါမယ်
CMD ["catalina.sh", "run"]
