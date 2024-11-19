Oppgave 1

-besvarelse1 kan få en 502 internal server error pga cold start, hvis dette skjer så prøv api'et 2 ganger
-besvarelse1:https://q61l4ti5bb.execute-api.eu-west-1.amazonaws.com/Prod/generate-image/

-besvarelse2: https://github.com/Haakon514/devops-eksamen-2024/actions/runs/11827433524/job/32955563686

Opggave 2

-besvarelse1:https://github.com/Haakon514/devops-eksamen-2024/actions/runs/11844252115

-besvarelse3:https://github.com/Haakon514/devops-eksamen-2024/actions/runs/11844418784/job/33007596391

-besvarelse2:https://sqs.eu-west-1.amazonaws.com/244530008913/image_async_queue

Oppgave 3

-besvarelse1:Container image mitt består av 2 tags, en kort commit hash tag og en latest tag.
    -commit hashen er en unik tag som gjør at man skille alle versjoner av koden som ble brukt til å bygge imagen, dette gjør at man kan lett skille mellom ulike versjoner av koden som er god practice for versjonkontroll og sporing.
    -latest tagen er en tag som gjør at man lett vet hvilken versjon av koden som ble pushet sist. dette gjør det lett for å finne den siste versjonen av koden.

-besvarelse2:hagu021/java_sqs_client_45
-bruk: https://sqs.eu-west-1.amazonaws.com/244530008913/image_async_queue som parameter i docker run kommandoen med -e når du tester imaget sammen med aws acces keys

Oppgave 4

-alarm-navn: oldestMessage-sqs-alarm-45

Oppgave 5

-(ci/cd) tilnærming: En serverless-arkitektur som bryter opp mikrotjenester til mindre isolerte funksjoner gjør at ci/cd pipelines kan bli komplekse fordi det er flere selvstendige funksjoner som har behov for versjonskontroll og håndtering av avhengigheter.
Det at funksjonene er små og gjerne bare har et gjøremål gjør gjerne at utrulling og automatisering av server-less arkitekturer fort kan bli enklere enn større mikrotjeneste enheter.
Så alt i alt så kan ci/cd pipelines i større mikrotjeneste arkitekturer være enklere og mindre komplekse fordi det er større enheter. 
Serverless-arkitekturer blir fort store, bestående av mange funksjoner som kan gjøre ci/cd pipelines komplekse.
På den andre siden så består serverless-arkitekturer av små selvstendige og isolerte funksjoner som kan gjøre automatisering, utrulling, og testing av de mindre enhetene lettere i serverless-arkitekturer enn i mikrotjeneste-arkitekturer.

-(overvåknings) tilnærming: overvåkning, logging og feilsøking endres mye fra en mikrotjeneste-arkitektur til en serverless-arkitektur. 
I en serverless arkitektur så skiftes fokuset fra infrastruktur overvåkning til bare ytelses overvåkning fordi i en serverless-arkitektur så håndterer tjenesteleverandøren skalering og maskinvare som gjør at man har mindre kontroll over infrastruktur og kan fokusere på applikasjons ytelse. 
Serverless-arkitekturer har også aspekt som Cold-starts som også trenger å bli overvåket for at ikke bruker opplevelsen blir dårligere. 
I mikrotjeneste-arkitekturer må man sette opp overvåkning manuelt, men i serverless-arkitekturer så er det gjerne tjenesteleverandøren som tilbyr overvåkning og loggdata verktøy som for eksempel cloudwatch i AWS som overvåker individuelle lambda serverless-funksjoner, dette kan redusere fleksibilitet i hvordan man overvåker systemet. 
Med store mengder mindre funksjoner som har korte livsløp i serverless-arkitekturer kan også generere store mengder loggdata i forhold til mikrotjenester som kan være mer kostbart og komplekst. 
På den andre siden så kan det være enklere å identifisere problemer i serverless-arkitekturer med at man kan sette på alarmer for hver enkelt funksjon.

-(Skalerbarhet og kostnadskontroll) tilnærming: Serverless-arkitekturer byr på automatisk skalerbarhet ved trafikk mengde som gjør at ingen manuell konfigurasjons trengs. 
Du betaler også kun for ressurser når de er i bruk som for eksempel funksjonskall målt i millisekunder, men dette kan føre til Cold starts når man må starte instanser som ikke har vært i bruk i en viss periode. 
Mikrotjeneste-arkitekturer byr på mer fleksibilitet og manuell konfigurasjon av infrastruktur som gjør at man kan manuelt skalere tjenester vertikalt og horisontalt etter hvor mye trafikk hver tjeneste har. 
Mikrotjenester har ingen Cold-starts men kan ha problemer med sløsing som overprovisioning hvis man kjører kostbar maskinvare uten mye trafikk i applikasjonen. 
Så en serverless-arkitektur er ideelt for en applikasjon med uforutsigbar eller lav trafikk der kostnader kan være veldig lave for å kjøre applikasjoner. 
Mikrotjeneste-arkitekturer lønner seg for applikasjoner med konstant trafikk eller spesifikke ressursbehov der man gjerne har en fast pris for maskinvare som kan lønne seg ved høy trafikk.

-(Eierskap og ansvar) tilnærming: En serverless-arkitektur flytter devops-teamets ansvar fra infrastruktur nivå til applikasjonsnivå, ansvaret flyttes oppover i stacken, dette reduserer kompleksitet, men reduserer også eierskap til applikasjonen. 
Infrastrukturen er da fullt kontrollert av tjenesteleverandør som gir teamet mulighet til å fokusere på applikasjonen ytelse, men mister eierskap og ansvar til infrastrukturen i applikasjonen. 
I en mikrotjeneste-arkitektur så har teamet fullt ansvar gjennom hele applikasjon der de selv står får infrastruktur og applikasjonens ytelse. 
Dette gjør at teamet har fullt eierskap til applikasjonen, men har også fullt ansvar som gjør at det krever mer administrasjon, ressursoptimalisering og overvåkning av applikasjonen.
