#!/usr/bin/perl
# Bryan Tsai (brtsai@ucsc.edu)
#
# Grading helper script
#

use strict;
use warnings;

use Cwd;
use File::Copy qw(copy);


my $adminDirectory =
   '/afs/cats.ucsc.edu/class/cmps112-wm.f15/.admin';
my $asgDir = 
   '/afs/cats.ucsc.edu/courses/cmps112-wm/Assignments/asg4-perl-pmake/.score';
my $myID = 'brtsai';
my $currentAsg = 'asg4';
my $className = 'cmps112-wm.f15';


my @gradingList = ();
my @toBeCopied = ('test.*');

############
# Load grading directory and get assignments to grade
# 
# Preconditions:
#    - Students' usernames are made of word characters
#
# Postconditions:
#


sub getGradingList{
   my $originaldir = getcwd;
   
   chdir("$adminDirectory" . "\/\.graders");
   my $filename = "${currentAsg}\.graders";

   open(my $file, "<", $filename) 
      or die "cannot find ${currentAsg}\.graders";

   while (defined(my $line = <$file>)) {

      # Matches lines that start with the user's ID and
      # assumes the next one or two words are students whose
      # assignments are assigned to be graded by the user
      # and adds these students to the grading list.

      chomp $line;

      if( $line =~ /$myID (\w+) (\w+)/ ){

         push @gradingList, $1;
         push @gradingList, $2;

      }elsif( $line =~ /$myID (\w+)/ ){


         push @gradingList, $1;

      }


   }

   chdir("$originaldir");
}


############
# Prints the current Grading List

sub printGradingList{

   for (@gradingList){
      print "$_\n";
   }

}


###########
# Copies all of the grading files needed into each students' folder
#
#

sub copyGradingFiles{
   my $originaldir = getcwd;


   chdir("$asgDir");


   my @files = `ls -1`;

   my @toCopy;

   for (@files){
      chomp $_;
      for my $name(@toBeCopied){
         if($_ =~ /$name/){
            push @toCopy, $_;
         }
      }
   }

   for (@toCopy){
      print "$_\n";
   }

   my $copyString;

   for (@toCopy){
   $copyString = $copyString . " ";
   }

   for (@gradingList){
      my $person = $_;
      for (@toCopy){
         #system("cp -R ", $_,
         #       " $adminDirectory" . "\/$currentAsg" . "\/$person");
         print ("cp -R ", $_,
                " $adminDirectory" . "\/$currentAsg" . "\/$person\n");
      }
      #system("cp -R ", $copyString, 	
      #       "$adminDirectory" . "\/$currentAsg" . "\/$_");
   }

   chdir("$originaldir");

}


getGradingList;
#printGradingList;
copyGradingFiles;













