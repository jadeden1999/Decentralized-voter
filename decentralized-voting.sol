pragma solidity >= 0.7.0<0.9.0;


contract Ballot {
    struct Voter {
        uint vote;
        bool voted;
        uint weight;

    }
    struct Proposal {


        bytes32 name;
        uint voteCount; 
        

    }

    Proposal[] public proposals;
//mapping allows for us to create a store value with keys and indexes

mapping(address => Voter) public voters;
address public chairperson;


constructor (bytes32[] memory proposalNames) {
    chairperson = msg.sender; 
    voters[chairperson].weight = 1;
    for(uint i=0; i < proposalNames.length; i++ ) {
        proposals.push(Proposal({

            name: proposalNames[i],
            voteCount: 0
        }));

    }
    
    
     }
    // authenticate votre
function giveRightToVote(address voter) public {

    require(msg.sender == chairperson , "Only an chairperson can vote ");
    require(!voters[voter].voted, "the voter has already voted ");
    require(voters[voter].weight == 0);
    voters[voter].weight = 1;
}

function vote(uint proposal) public {

Voter storage sender = voters[msg.sender];
require(sender.weight != 0 , "Has no right to vote");
require(!sender.voted, "Already Voted");
sender.voted = true;
sender.vote = proposal;

proposals[proposal].voteCount = proposals[proposal].voteCount + sender.weight;
}
    // function for voting 

// functions for showing the reuslts 


// function that shows the winning proposal by integer
function winningProposal() public view returns(uint winningProposal_) {
                                             
    uint winningVoteCount = 0 ;
    for(uint i = 0; i < proposals.length; i++) {


        if(proposals[i].voteCount > winningVoteCount) {

            winningVoteCount = proposals[i].voteCount; 
            winningProposal_ = i;

        }
    }
}

function winningName() public view returns (bytes32 winningName_)  {


    winningName_ = proposals[winningProposal()].name;
}
}
