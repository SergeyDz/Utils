T4 working project with ability to clone and extend domain model form existing DLL

Initial Task: 
Let's consider we will work with 3-d party DLL using POCO objects. But in case of our project, some of objects should contains some additional properties. 

Solution: 
Using custom T4 template to generate own POCO classes + auto-generated mappers for both directions conversion. 
In separate partial class extend target class with own properties. 

Example: 
See Template\Generated\Address.generated.cs class and its extension properties in Classes\Address.cs

How to: 
1. Open DomainModelGenerator.tt
2. Add requested class names to "types"
3. Save tt (or use VS->Run Custom Tool)
4. Generated file will be placed to Templates\Generated folder. 
	If this is new one - just add file to project. Otherwise, class content will be overwritten.  